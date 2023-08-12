//
//  BubbleViewLabel.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/8/23.
//

import SwiftUI

struct BubbleViewLabel: View {
    let goalId: UUID
    @Binding var focusGoal: UUID
    var width: CGFloat = 180
    var height: CGFloat = 50
    var offset: CGFloat = 0
    var shouldShowDetails = true
    @State var goal: Goal? = Goal()
    @State var shouldLoadImage = false
    
    @State var image: UIImage? = nil
    var shouldShowStatusLabel = false
    @EnvironmentObject var vm: ViewModel
    var color: CustomColor = .grey3
    var highlightColor: CustomColor = .purple
    var ignoreImageLoad: Bool = false
    var ignoreImageRefresh: Bool = false
    var body: some View {
        HStack{
            
            ZStack{
                ImageCircle(imageSize: SizeType.minimumTouchTarget.ToSize(), image: image, iconSize: .medium, icon: .goal)
                
                if shouldShowStatusLabel{
                    Circle()
                        .foregroundColor(.specify(color: GetColor()))
                        .frame(width:SizeType.tiny.ToSize(), height:SizeType.tiny.ToSize())
//                            .opacity(goal?.progress ?? 0 >= 99 ? 1.0 : 0.0)
                        .offset(x:15,y:15)
                }
            }
                if goal != nil && width > 50{
                    VStack(alignment:.leading){
                        Text(goal!.title)
                            .font(.specify(style: .caption))
                            .lineLimit(3)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.specify(color: .grey10))
                    }
                    Spacer()
                }
            }
            .opacity(shouldShowDetails ? 1.0 : 0.0)
            .padding(7)
            .modifier(ModifierCard(color: focusGoal == goalId ? highlightColor : color))
            .offset(x: offset)
            .frame(width:width < 50 ? 50 : width, height:50)
            .onAppear{
                if !ignoreImageLoad{
                    shouldLoadImage.toggle()
                }
            }
            .onChange(of: vm.updates.image){
                _ in
                if !ignoreImageRefresh{
                    shouldLoadImage.toggle()
                }
            }
            .onChange(of: vm.updates.goal){
                _ in
                if !ignoreImageRefresh{
                    shouldLoadImage.toggle()
                }
            }
            .onChange(of: shouldLoadImage){
                _ in
                LoadImage()
            }
    }
    
    func LoadImage(){
        goal = vm.GetGoal(id: goalId)
        DispatchQueue.global(qos:.background).async{
            if goal?.image != nil {
                image = vm.GetImage(id: goal!.image!)
            }
        }
    }
    
    func GetColor() -> CustomColor{
        if let goal{
            
            if goal.startDate > Date(){
                
                if goal.progress.toStatusType() == .notStarted{
                    return .grey5
                }
            }
            switch goal.progress.toStatusType(){
            case .notStarted:
                return .red
            case .inProgress:
                return .yellow
            case .completed:
                return .green
            }
        }
        return .grey5
    }
}

//struct BubbleViewLabel_Previews: PreviewProvider {
//    static var previews: some View {
//        BubbleViewLabel()
//    }
//}
