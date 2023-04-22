//
//  ModalAdd.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/20/23.
//

import SwiftUI

struct ModalAdd: View {
    @Binding var isPresenting: Bool
    @Binding var isPresentingPhotoSource: Bool
    @Binding var sourceType: UIImagePickerController.SourceType?
    let objectId: UUID?
    var parentId: UUID?
    @State var properties: Properties
    let objectType: ObjectType
    let modalType: ModalType
    var status: StatusType?
    @State var shouldAct = false
    @State var title = ""
    @State var description = ""
    @State var aspect = ""
    @State var priority = ""
    @State var coreValue = ""
    @State var timeframeString = ""
    @State var timeframe = TimeframeType.day
    @State var startDate = Date()
    @State var numberOf = 0
    @State var endDate = Date()
    @State var filteredValues = [ValueType]()
    @State var isPresentingImagePicker: Bool = false
    @State var chapterString = ""
    @State var image: UIImage? = nil
    @State var images: [UIImage] = [UIImage]()
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        
        Modal(modalType: modalType, objectType: objectType, isPresenting: $isPresenting, shouldConfirm: $shouldAct, isPresentingImageSheet: $isPresentingPhotoSource,  title: title.count > 0 ? title : modalType == .add ? "New "  + objectType.toString() : "Empty " + objectType.toString(), image: image, modalContent: {
            
            VStack(spacing:10){
                
                if parentId != nil {
                    if let parentGoal = vm.GetGoal(id: parentId!){
                        FormLabel(fieldValue: parentGoal.title, fieldName: "Parent " + parentGoal.timeframe.toString() + " goal", iconType: .arrow_up, shouldShowLock: true)
 
                        
                        Text("When a " + objectType.toString() + " has a parent goal, certain attributes are set and managed by the parent goal, including timeframe, aspect and start date.")
                            .frame(maxWidth:.infinity)
                            .padding([.leading,.trailing])
                            .padding(.bottom,30)
                            .font(.specify(style: .caption))
                            .foregroundColor(.specify(color: .grey4))
                            .multilineTextAlignment(.leading)
                    }
                }
                
                ForEach(PropertyType.allCases){ property in
                    
                    if objectType.hasProperty(property: property){
                        GetFormControl(property:property)
                    }
                }
                
            }
            .sheet(isPresented: $isPresentingImagePicker){
                ImagePicker(image: $image, showImagePicker: self.$isPresentingImagePicker, sourceType: self.sourceType ?? .camera)
            }
            .onAppear{
                SetupFields()
            }
            .padding(8)
            .onChange(of:timeframeString){ _ in
                GetTimeframeFromString()
            }
            .onChange(of: image){
                _ in
                if image != nil {
                    sourceType = nil
                    isPresentingPhotoSource = false
                    if objectType.hasProperty(property: .images){
                        images.append(image!)
                    }
                }

            }
            .onChange(of: timeframe){
                _ in
                numberOf = 0
                endDate = startDate.AdvanceDate(timeframe: timeframe, forward: true)
            }
            .onChange(of: numberOf){
                _ in
                endDate = startDate.ComputeEndDate(timeframeType: timeframe, numberOfDates: numberOf)
            }
            .onChange(of: startDate){
                _ in
                endDate = startDate.ComputeEndDate(timeframeType: timeframe, numberOfDates: numberOf)
            }
            .onChange(of: shouldAct){ _ in
                UpdateProperties()
                TakeAction()
            }
            .onChange(of: coreValue){ _ in
                if objectType == .value {
                    title = coreValue
                }
            }
            .onChange(of: aspect){ _ in
                if objectType == .aspect {
                    title = aspect
                }
            }
            .onChange(of: sourceType){
                _ in
                if sourceType != nil {
                    isPresentingImagePicker = true
                }
                else{
                    isPresentingImagePicker = false
                }
            }
        }, headerContent: {EmptyView()})
    }
    
    @ViewBuilder
    func GetFormControl(property: PropertyType) -> some View{
        
        switch property {
        case .title:
            FormText(fieldValue: $title, fieldName: PropertyType.title.toString(), axis: .horizontal, iconType: .title)
        case .description:
            FormText(fieldValue: $description, fieldName: GetDescriptionFieldName(), axis: .vertical, iconType: .description)
        case .timeframe:
            if parentId != nil && modalType != .add {
                FormLabel(fieldValue: timeframeString, fieldName: PropertyType.timeframe.toString(), iconType: .timeframe, shouldShowLock: true)
            }
            else{
                FormStackPicker(fieldValue: $timeframeString, fieldName: PropertyType.timeframe.toString(), options: TimeframeType.allCases.map({$0.toString()}),iconType: .timeframe)
            }
        case .startDate:
            FormCalendarPicker(fieldValue: $startDate, fieldName: GetStartDateFieldName(), timeframeType: $timeframe, iconType: .dates, isStartDate: true)
        case .endDate:
            FormCounter(fieldValue: $numberOf, fieldName: GetNumberOfFieldName(), iconType: .dates, maxValue: ComputeMaxValue())
            FormLabel(fieldValue: endDate.toString(timeframeType: timeframe, isStartDate: false), fieldName: PropertyType.endDate.toString(), iconType: .dates, shouldShowLock: true)
        case .aspect:
            
            if objectType == .aspect{
                let savedAspects = vm.ListAspects().map({$0.aspect.toString()})
                let allAspects = AspectType.allCases.map({$0.toString()})
                
                FormStackPicker(fieldValue: $aspect, fieldName: PropertyType.aspect.toString(), options: allAspects.filter({savedAspects.index(of: $0) == nil}), iconType: .aspect, isSearchable: true)
            }
            
            else{
                if parentId != nil {
                    FormLabel(fieldValue: aspect, fieldName: PropertyType.aspect.toString(), iconType: .aspect, shouldShowLock: true)
                }
                else{
                    FormStackPicker(fieldValue: $aspect, fieldName: PropertyType.aspect.toString(), options: AspectType.allCases.map({$0.toString()}),iconType: .aspect)
                }
            }
        case .priority:
            FormStackPicker(fieldValue: $priority, fieldName: PropertyType.priority.toString(), options: PriorityType.allCases.map({$0.toString()}),iconType: .priority)
//        case .progress:
//            <#code#>
//        case .parentId:
//            <#code#>
        case .coreValue:
            if modalType == .add {
                FormStackPicker(fieldValue: $coreValue, fieldName: PropertyType.coreValue.toString(), options: ValueType.allCases.filter({vm.GetCoreValue(coreValue: $0) == nil && $0 != .Introduction && $0 != .Conclusion}).map{$0.toString()}, iconType: .value, isSearchable: true)
            }
            else{
                FormLabel(fieldValue: coreValue, fieldName: PropertyType.coreValue.toString(), iconType: .value, shouldShowLock: true)
            }
//        case .edited:
//            <#code#>
//        case .leftAsIs:
//            <#code#>
//        case .pushedOff:
//            <#code#>
//        case .deleted:
//            <#code#>
//        case .start:
//            <#code#>
//        case .end:
//            <#code#>
        case .chapter:
            let chapters = vm.ListChapters()
            FormStackPicker(fieldValue: $chapterString, fieldName: PropertyType.chapter.toString(), options: chapters.map({$0.title}), iconType: .chapter)
        case .images:
            FormImages(fieldValue: $images, shouldPopImagesModal: $isPresentingPhotoSource, fieldName: PropertyType.images.toString(), iconType: .photo)
        default:
            let _ = "why"
        }
    }
    
    func TakeAction(){
        
        if objectType.hasProperty(property: .image) && ( (image != nil && properties.image == nil) || (properties.image != nil && image != vm.GetImage(id: properties.image!))) {
            let imageId = vm.CreateImage(image: image!)
//            let image = vm.GetImage(id: imageId)
            properties.image = imageId
        }
        else if objectType.hasProperty(property: .images){
            
            if objectId == nil{
                if images.count > 0{
                    properties.images = [UUID]()
                    for image in images{
                        properties.images!.append(vm.CreateImage(image: image))
                    }
                }
            }
            else if objectId != nil && objectType.hasProperty(property: .images) && properties.images != nil {
                
                //get rid of deleted images from properties
                for imageId in properties.images!{
                    if let image = vm.GetImage(id: imageId){
                        if !images.contains(image){
                            _ = vm.DeleteImage(id: imageId)
                        }
                    }
                }
                
                //add new images
                var storedImages = [UIImage]()
                
                for index in 0...properties.images!.count - 1{
                    if let image = vm.GetImage(id: properties.images![index]){
                        storedImages.append(image)
                    }
                }
                
                for image in images{
                    if !storedImages.contains(image){
                        properties.images!.append(vm.CreateImage(image: image))
                    }
                }
            }
        }
        
        
        
        switch objectType {
        case .value:
            if modalType == .add {
                _ = vm.CreateCoreValue(request: CreateCoreValueRequest(properties: properties))
            }
            if modalType == .edit  && objectId != nil {
                _ = vm.UpdateCoreValue(id: objectId!, request: UpdateCoreValueRequest(properties: properties))
            }
        case .dream:
            if modalType == .add {
                _ = vm.CreateDream(request: CreateDreamRequest(properties: properties))
            }
            if modalType == .edit  && objectId != nil {
                _ = vm.UpdateDream(id: objectId!, request: UpdateDreamRequest(properties: properties))
            }
        case .aspect:
            if modalType == .add {
                _ = vm.CreateAspect(request: CreateAspectRequest(properties: properties))
            }
            if modalType == .edit && objectId != nil  {
                _ = vm.UpdateAspect(id: objectId!, request: UpdateAspectRequest(properties: properties))
            }
        case .goal:
            if modalType == .add {
                _ = vm.CreateGoal(request: CreateGoalRequest(properties: properties))
            }
            if modalType == .edit && objectId != nil {
                _ = vm.UpdateGoal(id: objectId!, request: UpdateGoalRequest(properties: properties))
            }
//        case .session:
//            <#code#>
        case .task:
            if modalType == .add {
                _ = vm.CreateTask(request: CreateTaskRequest(properties: properties))
            }
            if modalType == .edit && objectId != nil {
                _ = vm.UpdateTask(id: objectId!, request: UpdateTaskRequest(properties: properties))
            }
        case .chapter:
            if modalType == .add {
                _ = vm.CreateChapter(request: CreateChapterRequest(properties: properties))
            }
            if modalType == .edit && objectId != nil {
                _ = vm.UpdateChapter(id: objectId!, request: UpdateChapterRequest(properties: properties))
            }
        case .entry:
            if modalType == .add {
                let id = vm.CreateEntry(request: CreateEntryRequest(properties: properties))
                let entry = vm.GetEntry(id: id)
                print(entry)
            }
            if modalType == .edit && objectId != nil {
                _ = vm.UpdateEntry(id: objectId!, request: UpdateEntryRequest(properties: properties))
            }
//        case .habit:
//            <#code#>
//        case .home:
//            <#code#>
//        case .chapter:
//            <#code#>
//        case .entry:
//            <#code#>
//        case .emotion:
//            <#code#>
//        case .stats:
//            <#code#>
        default:
            let _ = ""
        }

        
        isPresenting = false
    }
    
    func SetupFields(){
        
        if modalType == .add{
            
            properties = Properties()
            
            if objectType == .goal{
                GetValuesFromParent()
            }
        }
        else if modalType == .edit{
            if objectId != nil {
                switch objectType {
                case .value:
                    if let coreValue = vm.GetCoreValue(id: objectId!){
                        properties = Properties(value: coreValue)
                    }
                case .goal:
                    if let goal = vm.GetGoal(id: objectId!){
                        properties = Properties(goal: goal)
                    }
                    GetValuesFromParent()
                case .task:
                    if let task = vm.GetTask(id: objectId!){
                        properties = Properties(task: task)
                    }
                case .dream:
                    if let dream = vm.GetDream(id: objectId!){
                        properties = Properties(dream: dream)
                    }
                case .chapter:
                    if let chapter = vm.GetChapter(id: objectId!){
                        properties = Properties(chapter:chapter)
                    }
                case .entry:
                    if let entry = vm.GetEntry(id: objectId!){
                        properties = Properties(entry: entry)
                    }
                default:
                    properties = Properties()
                }
            }
        }
        
        
        title = properties.title ?? ""
        description = properties.description ?? ""
        aspect = properties.aspect?.toString() ?? ""
        timeframeString = properties.timeframe?.toString() ?? ""
        priority = properties.priority?.toString() ?? ""
        startDate = properties.startDate ?? Date()
        numberOf = 0
        endDate = properties.endDate ?? Date()
        coreValue = properties.coreValue?.toString() ?? ""
        image = vm.GetImage(id: properties.image ?? UUID())
        
        if properties.images != nil {
            for imageId in properties.images!{
                if let image = vm.GetImage(id: imageId){
                    images.append(image)
                }
            }
        }

    }
    
    func UpdateProperties(){
//        if objectType == .goal {
            
        if modalType == .add {
            properties.parent = parentId
        }
        
        properties.coreValue = ValueType.allCases.first(where:{$0.toString() == coreValue})
        properties.title = title
        properties.description = description
        properties.aspect = AspectType.allCases.first(where:{$0.toString() == aspect})
        properties.timeframe = timeframe
        properties.startDate = startDate
        properties.endDate = endDate
        properties.priority = PriorityType.allCases.first(where:{$0.toString() == priority})
        properties.chapter = vm.ListChapters().first(where: {$0.title == chapterString})?.id
        if modalType == .add {
            properties.progress = status?.toInt() ?? 0
        }
//        }
    }
                
    func ComputeMaxValue() -> Int{
        switch timeframe {
        case .decade:
            return 4
        case .year:
            return 10
        case .month:
            return 12
        case .week:
            return 4
        case .day:
            return 7
        }
    }
    
    func GetValuesFromParent() {
        if parentId != nil {
            if let goal = vm.GetGoal(id: parentId!){
                
                properties.timeframe = goal.timeframe.toChildTimeframe()
                properties.startDate = goal.startDate
                properties.endDate = startDate
                properties.priority = goal.priority
                properties.aspect = goal.aspect
                properties.image = goal.image
            }
        }
    }
    
    func GetDescriptionFieldName() -> String{
        if objectType == .entry {
            return "Entry"
        }
        else {return "Description"}
    }
    
    func GetStartDateFieldName() -> String{
        if objectType.hasProperty(property: .endDate){
            return PropertyType.startDate.toString()
        }
        else {
            return "Date"
        }
    }
    
    func GetNumberOfFieldName() -> String {
        return "Number of " + timeframe.toString() + "s"
    }
    
    func GetTimeframeFromString() {
        timeframe = TimeframeType.allCases.first(where:{$0.toString() == timeframeString}) ?? .day
    }
}

struct ModalAdd_Previews: PreviewProvider {
    static var previews: some View {
        ModalAdd(isPresenting: .constant(true), isPresentingPhotoSource: .constant(false), sourceType: .constant(.camera), objectId: UUID(), properties: Properties(), objectType: .goal, modalType: .add)
    }
}
