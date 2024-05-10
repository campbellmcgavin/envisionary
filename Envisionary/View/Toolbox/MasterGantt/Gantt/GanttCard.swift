//
//  GanttCard.swift
//  Envisionary
//
//  Created by Campbell McGavin on 11/15/23.
//

import SwiftUI

struct GanttCard: View {
    let parentGoalId: UUID
    let goalId: UUID
    let leftPadding: CGFloat
    var isMini = false
    
    @Binding var selectedGoalId: UUID
    @Binding var shouldShowPadding: Bool
    @State var shouldSelect: Bool = false
    @State var goal: Goal = Goal()
    @State var padding: CGFloat = .zero
    @State var image: UIImage? = nil
    
    @EnvironmentObject var vm: ViewModel
    private let bounceAnimation = Animation
        .easeInOut(
            duration: 1.0
        )
        .repeatForever(autoreverses: true)
    
    var body: some View {
        HStack(alignment:.center, spacing:0){
            HStack(alignment:.center){
                
                if parentGoalId == goalId{
                    ImageCircle(imageSize: SizeType.small.ToSize(), image: image, iconSize: .extraSmall, icon: .photo, iconColor: .grey5, circleColor: GetIconColor())
                        .shadow(color: IsSelected() ? (Color.specify(color: IsCompleted() ? .green : .lightPurple)) : .clear,radius: 5)
                        .padding(-3)
                }
                else if shouldShowPadding{

                    if IsSelected(){

                            IconButton(isPressed: $shouldSelect, size: isMini ? .extraSmall : .small, iconType: .confirm, iconColor: .grey10, circleColor: GetIconColor(), opacity: IsCompleted() ? 1.0 : 0.3, hasAnimation: false)
                                .shadow(color: .specify(color: IsCompleted() ? .green : .lightPurple),radius: 5)
                                .padding(-3)
                        
                    }
                    else{
                            IconButton(isPressed: $shouldSelect, size: isMini ? .extraSmall : .small, iconType: .confirm, iconColor: .grey10, circleColor: GetIconColor(), opacity: 1.0, hasAnimation: false)
                                .padding(-3)
                        
                    }
                }
                else if IsSelected(){
                    Rectangle()
                        .fill(Color.specify(color: GetIconColor()))
                        .frame(width: 5, height: isMini ? SizeType.extraSmall.ToSize() : SizeType.small.ToSize())
                        .shadow(color: Color.specify(color: IsCompleted() ? .green : .lightPurple),radius: 5)
                        .offset(x:4)
                }

                
                VStack(alignment:.leading){
                    Text(goal.title)
                        .frame(maxWidth:.infinity, alignment: .topLeading)
                        .font(.specify(style: .caption))
                        .foregroundColor(.specify(color: .grey10))
                        .shadow(color: .black,radius: 10)
                        .lineLimit(2)
                    
                    if IsSelected(){
                        HStack(alignment:.center){
                            BuildEmphasisText()
                            BuildDateText()
                        }
                        .shadow(color: .black,radius: 10)
                        .padding(.top,-5)
                        .lineLimit(1)
                        .padding(.top,-6)
                    }

                }
                .frame(height: SizeType.small.ToSize()+6)
                .padding(.leading,7)
                
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation{
                        if IsSelected(){
                            selectedGoalId = UUID()
                        }
                        else{
                            selectedGoalId = goalId
                        }
                    }
                }
            }
            .frame(height: SizeType.small.ToSize()+6)
            }
            .frame(width: IsSelected() ? 220 : 150)
            .frame(height: SizeType.small.ToSize()+6)
            .padding(.leading,GetInlineButtonPadding(padding: padding))
            .onAppear{
                padding = leftPadding
                goal = vm.GetGoal(id: goalId) ?? Goal()
                
                if parentGoalId == goalId{
                    image = vm.GetImage(id: goal.image ?? UUID())
                }
            }
            .onChange(of: shouldSelect){
                _ in
                withAnimation{
                    
                    if IsSelected(){
                        let amount = IsCompleted() ? 0 : 100
                        _ = vm.UpdateGoalProgress(id: goalId, progress: amount)
                    }
                    else{
                        selectedGoalId = goalId
                    }
                }

                
            }
            .onChange(of: vm.updates.goal){
                _ in
                if let goal = vm.GetGoal(id: goalId){
                    self.goal = goal
                }
            }
            .contentShape(Rectangle())
            .onTapGesture{
                
                if !IsCompleted(){
                    selectedGoalId = goalId
                }
            }
            
        }
    func IsSelected() -> Bool{
        return selectedGoalId == goalId
    }
    
    func GetInlineButtonPadding(padding: CGFloat) -> CGFloat {
        
        if parentGoalId == goalId{
            return 8
        }
        
        if shouldShowPadding {
            if padding > UIScreen.screenWidth - 260 && goalId == selectedGoalId{
                return UIScreen.screenWidth - 260
            }
            else{
                return padding
            }
        }
        else{
            return 8
        }
    }
    
    func GetIconColor() -> CustomColor {
        
        if IsSelected() {
            if IsCompleted(){
                return .green
            }
            else{
                return .purple
            }
        }

        else{
            if IsCompleted(){
                return .darkGreen
            }
            else{
                return .grey3
            }
        }
    }
    
    func IsCompleted() -> Bool {
        return goal.progress >= 100
    }
    
    @ViewBuilder
    func BuildDateText() -> some View{
        
        if let startDate = goal.startDate{
            if let endDate = goal.endDate{
                let text = goal.completedDate == nil ?
                "\(startDate.toString(timeframeType: .day)) - \(endDate.toString(timeframeType: .day))" :
                goal.completedDate!.toString(timeframeType: .day)
                
                 Text(text)
                    .font(.specify(style: .subCaption))
                    .foregroundColor(.specify(color: .grey5))
            }
        }
    }
    
    func GetEmphasisText() -> String{
        if IsCompleted(){
            return "Completed"
        }
        else if let endDate = goal.endDate{
            if let startDate = goal.startDate{
                if endDate.isBefore(date: Date().StartOfDay()){
                    let daysBehind = endDate.GetDateDifferenceAsDecimal(to: Date.now, timeframeType: .day)
                    return "Late (\(Int(abs(daysBehind))) days)"
                }
                else if ((startDate.isInToday) || (endDate.isInToday) || (startDate.isInThePast && endDate.isInTheFuture)){
                    return "Now"
                }
                else if startDate.isInTheFuture{
                    return "Future"
                }
            }
        }
        
        return ""
        
    }
    
    @ViewBuilder
    func BuildEmphasisText() -> some View{
        let emphasisText = GetEmphasisText()
        if emphasisText.count > 0 {
            Text(emphasisText)
                .font(.specify(style: .subCaption))
                .foregroundColor(.specify(color: GetEmphasisTextColor(text: emphasisText)))
        }
    }
    
    func GetEmphasisTextColor(text: String) -> CustomColor{
        
        if text == "" {
            return .clear
        }
        else if text.contains("Completed")
        {
            return .darkGreen
        }
        else if text.contains("Date Match") || text.contains("Now") || text.contains("Future")
        {
            return .blue
        }
        else if text.contains("Late"){
            return .red
        }
        return .clear

    }
}

struct GanttCard_Previews: PreviewProvider {
    static var previews: some View {
        let id = UUID()
        GanttCard(parentGoalId: id, goalId: id, leftPadding: 0, selectedGoalId: .constant(UUID()), shouldShowPadding: .constant(false))
    }
}
