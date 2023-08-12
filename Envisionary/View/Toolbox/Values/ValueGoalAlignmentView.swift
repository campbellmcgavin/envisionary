//
//  CoreValuesView.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/10/23.
//

import SwiftUI

struct ValueGoalAlignmentView: View {
    let valueId: UUID
    @State var goals: [Goal] = [Goal]()
    @State var valueRatings: [CoreValueRating] = [CoreValueRating]()
    @EnvironmentObject var vm: ViewModel
    @State var errorLevel: Int = 2
    
    var body: some View {
        VStack(spacing:0){
            BuildMessage()
            
            ForEach(goals.sorted(by: {$0.title < $1.title})){ goal in
                CoreValuesViewRow(properties: Properties(goal: goal), objectType: .value, valueRating: BindingValueRating(for: goal))
            }
            .padding(.trailing,-7)
        }
        .padding(.bottom,-6)
        .onChange(of: valueRatings){
            _ in
            let redCount = valueRatings.filter({$0.amount == 0}).count > 0
            let yellowCount = valueRatings.filter({$0.amount == 1}).count > 0
            let notFinishedCount = valueRatings.filter({$0.amount == -1}).count > 0
            withAnimation{
                errorLevel = redCount ? 0 : yellowCount ? 1 : notFinishedCount ? -1 : 2
            }
        }
        .frame(maxWidth:.infinity)
        .onAppear{
            var criteria1 = Criteria()
            criteria1.archived = false
            criteria1.includeCalendar = false
            goals = vm.ListGoals(criteria: criteria1)
            
            var criteria2 = Criteria()
            criteria2.valueId = valueId
            let ratings = vm.ListCoreValueRatings(criteria: criteria2)
            let goalIds = goals.map({$0.id})
            
            // add ratings for goals that don't have one yet
            for goalId in goalIds{
                if !ratings.contains(where: {$0.parentGoalId == goalId}){
                    let request = CreateCoreValueRatingRequest(parentGoalId: goalId, valueId: valueId, amount: -1)
                    _ = vm.CreateCoreValueRating(request: request)
                }
            }
            
            //remove ratings for parent goals that no longer exist
            for rating in ratings{
                if !goals.contains(where:{$0.id == rating.parentGoalId}){
                    _ = vm.DeleteCoreValueRating(id: rating.id)
                }
            }
            valueRatings = vm.ListCoreValueRatings(criteria: criteria2)
        }
    }
    
    func BindingValueRating(for key: Goal) -> Binding<CoreValueRating>{
        return Binding(get: {
            return self.valueRatings.first(where: {$0.parentGoalId == key.id}) ?? CoreValueRating()},
                       set: {
            if let index = valueRatings.firstIndex(where: {key.id == $0.parentGoalId}){
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
    private func BuildMessage() -> some View{
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
                        Text("All of your goals are aligned with this specific value!")
                            .foregroundColor(.specify(color: .grey7))
                            .font(.specify(style: .h6))
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    else if errorLevel == -1{
                        Text("Go ahead and finish evaluating how this specific value checks with each of your goals.")
                            .foregroundColor(.specify(color: .grey7))
                            .font(.specify(style: .h6))
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    else if errorLevel == 1{
                        Text("Think about modifying any mis-aligned goals.")
                            .foregroundColor(.specify(color: .grey7))
                            .font(.specify(style: .h6))
                            .multilineTextAlignment(.leading)
                            .fixedSize(horizontal: false, vertical: true)
                            
                    }
                    else if errorLevel == 0{
                        Text("Think about getting rid of any misaligned goals. There. We said it.")
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
        .padding(.bottom)
    }
}
