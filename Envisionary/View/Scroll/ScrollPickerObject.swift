//
//  ScrollPickerObject.swift
//  Visionary
//
//  Created by Campbell McGavin on 4/14/22.
//

import SwiftUI

struct ScrollPickerObject: View {
    @EnvironmentObject var vm: ViewModel
    @Binding var objectType: ObjectType
    var isSearch: Bool?
    @State var isLoadingObjects: Bool = false
    
    @State var contentOffset = CGPoint(x:0,y:0)
    @State var buttonIsChangingObject = false
    @State var objectDisplay: ObjectType = .home
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var objectList = [ObjectType]()
    
    let weirdOffset = CGFloat(8)
    
    var body: some View {
        VStack{
            if ShouldShowObjects(){
                ZStack{
                    ScrollPickerSelectedRectangle()
                    
                    GeometryReader{
                        geometry in
                        ScrollPicker(frame: .constant(SizeType.scrollPickerWidth.ToSize()), weirdOffset: weirdOffset, $contentOffset, animationDuration: .constant(0.65), maxIndex: CGFloat(objectList.count - 1), axis: .horizontal, oneStop: false, content:{
                            HStack(alignment:.center){
                                ForEach(objectList, id:\.self){object in
                                    
                                    Button {
                                        contentOffset.x =  CGFloat(objectList.firstIndex(of: object) ?? 0) * (SizeType.scrollPickerWidth.ToSize() + weirdOffset)
                                        withAnimation{
                                            objectDisplay = object
                                        }
                                    } label: {
                                        ZStack{
                                            ScrollPickerObjectText(object: object, width: SizeType.scrollPickerWidth.ToSize(), selectionObject: $objectDisplay)
//                                                .frame(height:ShouldShowObjects() ? SizeType.minimumTouchTarget.ToSize() : 0)
//                                            Text(isLoadingObjects ? "T" : "F")
//                                                .foregroundColor(.specify(color: .grey10))
//                                                .opacity(0.0)
                                        }

                                        
                                    }
//                                    .frame(height:ShouldShowObjects() ? SizeType.minimumTouchTarget.ToSize() : 0)
                                    .offset(y:-3)
                                    
                                }
                            }
//                            .frame(height:ShouldShowObjects() ? SizeType.minimumTouchTarget.ToSize() : 0)
                            .padding(.leading, abs(geometry.size.width/2 - SizeType.scrollPickerWidth.ToSize()/2))
                            .padding(.trailing, abs(geometry.size.width/2 - SizeType.scrollPickerWidth.ToSize()/2))
                            
                        })
                    }

                }
            }
        }
        .frame(height:ShouldShowObjects() ? SizeType.minimumTouchTarget.ToSize() : 0)
        
            
        
        .onChange(of: contentOffset.x){ _ in
            objectDisplay = GetObjectFromOffset()
            self.startTimer()
            
        }
        .onChange(of: vm.filtering.filterContent){
            _ in
            withAnimation{
                LoadObjects()
            }
            isLoadingObjects.toggle()
        }
        .onAppear{
            LoadObjects()
            contentOffset.x = GetOffsetFromObject()
            objectDisplay = objectType
            self.startTimer()
            
            isLoadingObjects.toggle()
        }
        .onChange(of: objectList){
            _ in
            
            if isSearch == true {
                contentOffset.x = GetOffsetFromObject()
                objectDisplay = objectType
                self.startTimer()
            }
            else{
                contentOffset.x = CGFloat(0) * (SizeType.scrollPickerWidth.ToSize() * weirdOffset)
                objectDisplay = GetObjectFromOffset()
                self.startTimer()
            }
            isLoadingObjects.toggle()
        }
        .onChange(of: objectType){ _ in
            isLoadingObjects.toggle()
        }
        .onChange(of: objectDisplay){
            _ in
            let impact = UIImpactFeedbackGenerator(style: .light)
                  impact.impactOccurred()
        }
        .onReceive(timer){ _ in
            DispatchQueue.main.async{
                withAnimation{
                    self.stopTimer()
                    objectType = objectDisplay
                }
                isLoadingObjects.toggle()
            }
            
        }

    }
    
    func LoadObjects() {
        isLoadingObjects.toggle()
        objectList.removeAll()
        
        for object in ObjectType.allCases {
            
            if ObjectShouldShow(object: object){
                objectList.append(object)
            }
        }
    }
    
    func ObjectShouldShow(object: ObjectType) -> Bool{
        
        if isSearch == true{
            switch object {
            case .value:
                return true
            case .creed:
                return false
            case .dream:
                return true
            case .aspect:
                return true
            case .goal:
                return true
            case .session:
                return true
            case .task:
                return true
            case .habit:
                return true
            case .home:
                return false
            case .chapter:
                return true
            case .entry:
                return true
            case .emotion:
                return true
            case .stats:
                return false
            case .prompt:
                return false
            }
        }
        
        else{
            switch vm.filtering.filterContent{
            case .envision:
                return object == .value || object == .creed || object == .dream || object == .aspect
            case .plan:
                return object == .goal || object == .session || object == .task || object == .habit
            case .execute:
                return object == .home
            case .journal:
                return object == .chapter || object == .entry || object == .emotion
            case .evaluate:
                return object == .stats
            }
        }

    }
    
    
    func GetOpacity(object: ObjectType) -> CGFloat{
        
        if object == objectDisplay {
            return 1.0
        }
        return 0.5
    }
    
    func GetContentForObject() -> ContentViewType{
        
        switch vm.filtering.filterObject {
        case .aspect:
            return .envision
        case .value:
            return .envision
        case .creed:
            return .envision
        case .goal:
            return .plan
        case .session:
            return .plan
        case .task:
            return .plan
        case .habit:
            return .plan
        case .home:
            return .execute
        case .chapter:
            return .journal
        case .entry:
            return .journal
        case .stats:
            return .evaluate
        case .emotion:
            return .journal
        case .dream:
            return .envision
        case .prompt:
            return .execute
        }
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    }
    
    func GetObjectFromOffset() -> ObjectType {
        
        let offset = contentOffset.x
        let index = (offset) / (SizeType.scrollPickerWidth.ToSize() + self.weirdOffset)
        let indexRounded = Int(index.rounded(.toNearestOrAwayFromZero))
        if indexRounded < 0{
            return objectList.first!
        }
        else if indexRounded > objectList.count - 1 {
            return objectList.last!
        }
        else{
            return objectList[indexRounded]
        }
    }
    
    func GetOffsetFromObject() -> CGFloat {
        return CGFloat(objectList.firstIndex(of: objectType) ?? 0) * (SizeType.scrollPickerWidth.ToSize() + self.weirdOffset)
//        if isSearch == true{
//
//        }
//        else{
//            return 0
//        }
    }
    
    func ShouldShowObjects() -> Bool {
        return isSearch == true || (vm.filtering.filterContent != .execute && vm.filtering.filterContent != .evaluate)
    }
}

struct ScrollPickerObject_Previews: PreviewProvider {
    static var previews: some View {
        ScrollPickerObject(objectType: .constant(.goal))
            .environmentObject(ViewModel())
            .background(Color.specify(color: .grey0))
    }
}


