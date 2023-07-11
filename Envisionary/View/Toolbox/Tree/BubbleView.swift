//
//  BubbleView.swift
//  Visionary
//
//  Created by Campbell McGavin on 2/4/22.
//

import SwiftUI

struct BubbleView: View {
    let goalId: UUID
    @Binding var focusGoal: UUID
    var width: CGFloat = 180
    var height: CGFloat = 50
    var offset: CGFloat = 0
    var shouldShowDetails = true
    @State var goal: Goal? = Goal()
    @EnvironmentObject var vm: ViewModel
    @State var shouldLoadImage = false
    
    @State var image: UIImage? = nil
    var shouldShowStatusLabel = false
    
    var body: some View {

            Button{
                withAnimation{
                    if focusGoal == goalId {
                        focusGoal = UUID()
                    }
                    else {
                        focusGoal = goalId
                    }
                }
            }

        label:{
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

//                    Circle()
//                        .frame(width:SizeType.minimumTouchTarget.ToSize(), height: SizeType.minimumTouchTarget.ToSize())
//                        .foregroundColor(.specify(color: .grey5))
//                        .padding(.trailing, goal.title.count == "" ? 0 : -7)
                    if goal != nil && width > 50{
                        VStack(alignment:.leading){
                            Text(goal!.title)
                                .font(.specify(style: .caption))
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.specify(color: .grey10))
                            Text(goal!.timeframe.toString())
                                .textCase(.uppercase)
                                .font(.specify(style: .subCaption))
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.specify(color: focusGoal == goalId ? .grey10 : .grey5))
                        }
                        Spacer()
                    }

                }
                .opacity(shouldShowDetails ? 1.0 : 0.0)
                .padding(7)
                .modifier(ModifierCard(color: focusGoal == goalId ? .purple : .grey3))
                .offset(x: offset)
                .frame(width:width < 50 ? 50 : width, height:50)
                
            
                
        }
        .buttonStyle(.plain)
        .onAppear{
            shouldLoadImage.toggle()
        }
        .onChange(of: vm.updates.image){
            _ in
            shouldLoadImage.toggle()
        }
        .onChange(of: vm.updates.goal){
            _ in
            LoadImage()
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

struct BubbleView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleView(goalId: UUID(), focusGoal: .constant(UUID()), width: 3)
            .environmentObject(ViewModel())
    }
}
