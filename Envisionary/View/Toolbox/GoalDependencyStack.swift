//
//  GoalDependencyStack.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/8/23.
//

import SwiftUI

struct GoalDependencyStack: View {
    @Binding var isVisible: Bool
    let objectId: UUID
    let tapToShow: Bool
    @EnvironmentObject var vm: ViewModel
    let randomId = UUID()
    let randomGoal = Goal()
    @State var goalDescendency = [Goal]()
    @State var image: UIImage? = nil

    let numbers = 1...4
    let width: CGFloat = 180
    let height: CGFloat = 50
    let timerCount: Double = 25
    @State var timer = Timer.publish(every: 25, on: .main, in: .common).autoconnect()
    @State var offset: CGPoint = .zero
    var body: some View {
        ZStack{
            
            ObservableScrollView(axes: .horizontal, showsIndicators: false, offset: $offset){
                HStack{
                    if (!tapToShow && !isVisible) || isVisible{
                        ForEach(goalDescendency){goal in
                            HStack{
                                if goal != goalDescendency.first {
                                    IconLabel(size: .tiny, iconType: .arrow_right, iconColor: .grey5)
                                }
                                
                                NavigationLink(destination:
                                                Detail(objectType: .goal, objectId: goal.id), label: {
                                    
                                    BubbleViewLabel(goalId: goal.id, focusGoal: .constant(randomId), width: width, height: height, shouldShowDetails: true, goal: goal, image: image, shouldShowStatusLabel: true, color: .grey25, ignoreImageLoad: true)
                                        .environmentObject(vm)
                                        .scaleEffect(0.67)
                                        .padding([.trailing,.leading],-43)
                                })
                            }
                        }
                    }
                    else{
                        HStack{
                            ForEach(numbers.reversed(), id:\.self){
                                number in
                                HStack{
                                    if number != numbers.reversed().first {
                                        IconLabel(size: .tiny, iconType: .arrow_right, iconColor: .grey5)
                                    }
                                    BubbleViewLabel(goalId: randomId, focusGoal: .constant(randomId), width: width, height: height, shouldShowDetails: false, goal: randomGoal, image: nil, shouldShowStatusLabel: false, color: .grey25, highlightColor: .grey25, ignoreImageLoad: true)
                                        .scaleEffect(0.67)
                                        .padding([.trailing,.leading],-43)
                                        .opacity(0.5)
                                        .disabled(true)
                                }
                                .onTapGesture {
                                    withAnimation{
                                        isVisible = true
                                    }
                                }
                            }
                        }
                        .onChange(of: offset){
                            _ in
                            withAnimation{
                                isVisible = true
                            }
                        }
                    }
                }
                .padding(.trailing,90)
                .offset(x:20)
            }
            HStack{
                Spacer()

                    IconButton(isPressed: $isVisible, size: .medium, iconType: .envisionFilled, iconColor: .grey10, circleColor: isVisible ? .purple : .grey3, hasAnimation: true)

                    .background(
                        ZStack{
                            Circle()
                                .frame(width:SizeType.medium.ToSize() + 10, height:SizeType.medium.ToSize() + 10)
                                .foregroundColor(.specify(color:.grey15))
                            Rectangle()
                                .frame(width:SizeType.medium.ToSize() + 8, height:SizeType.medium.ToSize() + 8)
                                .foregroundColor(.specify(color:.grey15))
                                .offset(x:SizeType.medium.ToSize()/2)
                        }
                    )
            }

        }
        .frame(height:SizeType.mediumLarge.ToSize())
        .frame(maxWidth:.infinity)
        .onAppear(){
            goalDescendency = vm.ListGoalDescendency(id: objectId)
            image = vm.GetImage(id: goalDescendency.first?.image ?? UUID())
            stopTimer()
        }
        .onChange(of: isVisible){
            _ in
            startTimer()
        }
        .onReceive(timer){
            _ in
            stopTimer()
            withAnimation{
                isVisible = false
            }
        }
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: timerCount, on: .main, in: .common).autoconnect()
    }
}

struct GoalDependencyStack_Previews: PreviewProvider {
    static var previews: some View {
        GoalDependencyStack(isVisible: .constant(false), objectId: UUID(), tapToShow: true)
    }
}
