//
//  CoreValuesView.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/10/23.
//

import SwiftUI

struct GoalValueAlignmentView: View {
    let goalId: UUID
    @State var values: [CoreValue] = [CoreValue]()
    @State var valueRatings: [CoreValueRating] = [CoreValueRating]()
    @EnvironmentObject var vm: ViewModel
    @State var errorLevel: Int = 2
    @State var shouldShowAssessment: Bool = false
    @State var asessmentProgress: Int = 0
    var body: some View {
        VStack(){
            BuildMessage()
            

            
            if shouldShowAssessment {
                
                HStack{
                    IconLabel(size: .small, iconType: .info_nocircle, iconColor: .grey10, circleColor: .grey6)
                    
                    Text("FYI, Only super goals have value alignment. Any goal below this will not need alignment.")
                       .font(.specify(style: .caption))
                       .frame(maxWidth:.infinity)
                       .foregroundColor(.specify(color: .grey8))
                }
                .padding(8)
                .modifier(ModifierForm(color: .grey2, radius: .cornerRadiusSmall))

                
                
                VStack(spacing:0){
                    ForEach(values.sorted(by: {$0.title < $1.title})){ coreValue in
                        CoreValuesViewRow(properties: Properties(value: coreValue), objectType: .goal, valueRating: BindingValueRating(for: coreValue))
                    }
                    .padding(.trailing,-7)
                }

                
            }
            
            TextIconButton(isPressed: $shouldShowAssessment, text: shouldShowAssessment ? "Hide Assessment" : GetButtonText(), color: GetButtonTextColor(), backgroundColor: GetButtonColor(), fontSize: .h5, shouldFillWidth: true)
                .padding([.top,.bottom],8)
        }
        .padding(.bottom,-6)
        .onChange(of: valueRatings){
            _ in
            if !valueRatings.contains(where: {$0.amount == -1}){
                ComputeErrorLevel()
            }
            ComputeProgress()
        }
        .frame(maxWidth:.infinity)
        .onAppear{
            values = vm.ListCoreValues()
            var criteria = Criteria()
            criteria.parentId = goalId
            let ratings = vm.ListCoreValueRatings(criteria: criteria)
            let valueIds = values.map({$0.id})
            
            //add ratings for values
            for valueId in valueIds{
                if !ratings.contains(where: {$0.coreValueId == valueId}){
                    let request = CreateCoreValueRatingRequest(parentGoalId: goalId, valueId: valueId, amount: -1)
                    _ = vm.CreateCoreValueRating(request: request)
                }
            }
            
            // remove ratings for values that don't exist
            for rating in ratings{
                if !valueIds.contains(where:{$0 == rating.coreValueId}){
                    _ = vm.DeleteCoreValueRating(id: rating.id)
                }
            }
            valueRatings = vm.ListCoreValueRatings(criteria: criteria)
            
            ComputeErrorLevel()
            ComputeProgress()
        }
    }
    
    func GetButtonColor() -> CustomColor{
        if shouldShowAssessment{
            return .grey3
        }
        else{
            switch asessmentProgress{
            case 0:
                return .grey10
            case 1:
                return .grey10
            case 2:
                return .grey3
            default:
                return .grey3
            }
        }
    }
    
    func GetButtonTextColor() -> CustomColor{
        if shouldShowAssessment{
            return .grey10
        }
        else{
            switch asessmentProgress{
            case 0:
                return .grey0
            case 1:
                return .grey0
            case 2:
                return .grey10
            default:
                return .grey10
            }
        }
    }
    
    func GetButtonText() -> String{
        switch asessmentProgress{
        case 0:
            return "Take Assessment"
        case 1:
            return "Continue Assessment"
        case 2:
            return "Review Assessment"
        default:
            return ""
        }
    }
    
    func ComputeProgress() {
        if !valueRatings.contains(where: {$0.amount == -1}){
            asessmentProgress = 2
        }
        else if valueRatings.contains(where:{$0.amount != -1}) {
            asessmentProgress = 1
        }
        else{
            asessmentProgress = 0
        }
    }
    func ComputeErrorLevel() {
        let redCount = valueRatings.filter({$0.amount == 0}).count > 0
        let yellowCount = valueRatings.filter({$0.amount == 1}).count > 0
        let notFinishedCount = valueRatings.filter({$0.amount == -1}).count > 0
        withAnimation{
            errorLevel =  notFinishedCount ? -1 : redCount ? 0 : yellowCount ? 1 : 2
        }
    }
    
    func BindingValueRating(for key: CoreValue) -> Binding<CoreValueRating>{
        return Binding(get: {
            return self.valueRatings.first(where: {$0.coreValueId == key.id}) ?? CoreValueRating()},
                       set: {
            if let index = valueRatings.firstIndex(where: {key.id == $0.coreValueId}){
                self.valueRatings[index] = $0
            }
        })
    }
    
    func GetIcon() -> IconType{
        switch errorLevel{
        case -1:
            return .value
        case 0:
            return .alert
        case 1:
            return .alert
        case 2:
            return .confirm
        default:
            return .confirm
        }
    }
    
    func GetColor() -> CustomColor{
        switch errorLevel{
        case -1:
            return .blue
        case 0:
            return .red
        case 1:
            return .yellow
        case 2:
            return .green
        default:
            return .green
        }
    }
    
    @ViewBuilder
    func BuildMessage() -> some View{
        VStack(spacing:0){
            HStack(alignment:.center){
                IconLabel(size: .small, iconType: GetIcon(), iconColor: .grey10, circleColor: GetColor())
                
                if errorLevel == 2 {
                    Text("Two big thumbs up!")
                        .foregroundColor(.specify(color: .grey10))
                        .font(.specify(style: .h5))
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                }
                else if errorLevel == -1{
                    Text("Pending Value Assessment")
                        .foregroundColor(.specify(color: .grey10))
                        .font(.specify(style: .h5))
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                }
                else{
                    Text("Value misalignment.")
                        .foregroundColor(.specify(color: .grey10))
                        .font(.specify(style: .h5))
                        .multilineTextAlignment(.leading)
                        .lineLimit(3)
                }
                Spacer()
            }
            
            VStack{
                HStack{
                    if errorLevel == 2 {
                        Text("Your goal is aligned with every single one of your core values.")
                            .foregroundColor(.specify(color: .grey7))
                            .font(.specify(style: .h6))
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    else if errorLevel == -1{
                        Text("Go ahead and evaluate how your goal checks with each of your core values.")
                            .foregroundColor(.specify(color: .grey7))
                            .font(.specify(style: .h6))
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    else if errorLevel == 1{
                        Text("Think about modifying your goal so that it's in-line with your values.")
                            .foregroundColor(.specify(color: .grey7))
                            .font(.specify(style: .h6))
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            
                    }
                    else if errorLevel == 0{
                        Text("Think about getting rid of your goal.\nThere. We said it.")
                            .foregroundColor(.specify(color: .grey7))
                            .font(.specify(style: .h6))
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    Spacer()
                }
                HStack{
                    if errorLevel == 0{
                        Text("After all, what's the point of achieving anything if you hurt yourself in the process?")
                            .foregroundColor(.specify(color: .grey5))
                            .font(.specify(style: .caption))
                            .multilineTextAlignment(.leading)
                            .lineLimit(3)
                            .padding(.top,4)
                            .padding(.bottom,8)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    else if errorLevel == 1{
                        Text("After all, what's the point of achieving anything if it's not helping you become the best you can be?")
                            .foregroundColor(.specify(color: .grey5))
                            .font(.specify(style: .caption))
                            .multilineTextAlignment(.leading)
                            .lineLimit(3)
                            .padding(.bottom,8)
                            .padding(.top,4)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    Spacer()
                }
            }
            .padding(.leading,47)

        }
        .padding(8)
        .modifier(ModifierForm(color: .grey2, radius: .cornerRadiusSmall))
    }
}

struct CoreValuesView_Previews: PreviewProvider {
    
    static var previews: some View {
        GoalValueAlignmentView(goalId: UUID())
    }
}


struct CoreValuesViewRow: View {
    let properties: Properties
    let objectType: ObjectType
    @Binding var valueRating: CoreValueRating
    
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        HStack{
            
            NavigationLink(destination: Detail(objectType: objectType == .goal ? .value : .goal, objectId: properties.id), label: {
                ZStack{
                    TextIconLabel(text: properties.title ?? "", color: .grey10, backgroundColor: .grey2, fontSize: .h6, shouldFillWidth: true, iconType: objectType == .goal ? .value : .goal, iconPositionRight: false, iconOpacity: 0.35)
                    HStack{
                        Spacer()
                        IconLabel(size: .extraSmall, iconType: .right, iconColor: .grey35)
                    }
                }
            })
            .id(UUID())
            
            BadOkayGood(fieldValue: $valueRating.amount)
                .onChange(of: valueRating.amount){
                    _ in
                    _ = vm.UpdateCoreValueRating(id: valueRating.id, request: UpdateCoreValueRatingRequest(amount: valueRating.amount))
                }
        }
        .frame(maxWidth:.infinity)
    }
}
