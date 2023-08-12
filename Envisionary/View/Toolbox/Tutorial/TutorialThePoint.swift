//
//  TutorialThePoint.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/5/23.
//

import SwiftUI

struct TutorialThePoint: View {
    @Binding var canProceed: Bool
    @EnvironmentObject var vm: ViewModel
    @State var parentGoal: Goal = Goal()
    @State var expandedGoals: [UUID] = [UUID]()
    @State var focusGoal: UUID = UUID()
    @State var openPresent: Bool = false
    @State var shouldOpenPresent: Bool = false
    @State var shouldExpand: Bool = false
    
    var body: some View {
        VStack{
            ZStack{
                BuildView()
//                    .padding()
                    .onChange(of: shouldOpenPresent){ _ in
                        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { timer in
                            withAnimation{
                                self.openPresent = true
                            }
                        }
                    }
        }
            .onAppear{
                var criteria = Criteria()
                criteria.includeCalendar = false
                if let parent = vm.ListGoals(criteria: criteria).first{
                    parentGoal = parent
                    focusGoal = parent.id
                }
            }
            .onChange(of: shouldExpand){
                _ in
                
                let childGoals = vm.ListAffectedGoals(id: parentGoal.id).map({$0.id})
                expandedGoals.append(contentsOf: childGoals)
                canProceed = true
            }
Spacer()
        }
        .frame(maxWidth:.infinity)
        .frame(minHeight:450)
    }
    
    @ViewBuilder
    func BuildView() -> some View{
        if openPresent{
            VStack(spacing:0){
                Text("Your first goal! Looks like you are going to " + parentGoal.title.lowercased().replacingOccurrences(of: "my", with: "your") + "!")
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.specify(color: .grey9))
                        .font(.specify(style: .h5))
                        .frame(maxWidth:.infinity, alignment:.leading)
                        .padding()
                        .modifier(ModifierForm(color:.grey25, radius: .cornerRadiusSmall))
                        .padding(.bottom,8)
                    
                    if shouldExpand{
                        Text("Notice how the big idea is broken down into smaller ideas!!!")
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.specify(color: .grey9))
                            .font(.specify(style: .h5))
                            .frame(maxWidth:.infinity, alignment:.leading)
                            .padding()
                            .modifier(ModifierForm(color:.grey25, radius: .cornerRadiusSmall))
                            .padding(.bottom,8)
                    }
                    else{
                        TextIconButton(isPressed: $shouldExpand, text: "Open your goal!", color: .grey0, backgroundColor: .grey10, fontSize: .h3, shouldFillWidth: true, iconType: nil, hasAnimation: true)
                    }

                
                if openPresent{
                    ScrollView([.horizontal],showsIndicators: true){
                        HStack{
                            TreeView(goalId: parentGoal.id, focusGoal: $focusGoal, expandedGoals: $expandedGoals, value: { goalId in
                                BubbleView(goalId: goalId, focusGoal: $focusGoal, shouldShowStatusLabel: true)
                            }, childCount: 0)
                            .padding(.top,5)
                            .padding(.bottom)
                            Spacer()
                        }
                        .frame(width: UIScreen.screenWidth + 250)
                        .frame(alignment:.leading)
                    }
                    .padding(.top,50)
                }
                
            }
            .padding(8)
        }
        else{
            ZStack{
                Button{
                    withAnimation{
                        shouldOpenPresent = true
                    }
          
                }
            label:{
                ZStack{
                    "Shape_gift_bottom".ToImage(imageSize: 275)
                        .offset(x:40, y:100)
                        
                        
                    "Shape_gift_top".ToImage(imageSize: 225)
                        .wiggling(intensity:3.0)
                        .offset(y: shouldOpenPresent ? -85 : 0)
                }
                .wiggling(intensity:1.0)
                .transition(.move(edge: .bottom))
            }
            }
            .offset(y:55)
        }

    }
}

struct TutorialThePoint_Previews: PreviewProvider {
    static var previews: some View {
        TutorialThePoint(canProceed: .constant(true))
    }
}
