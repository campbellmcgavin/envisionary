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
    var ignoreImageLoad = false
    var ignoreImageRefresh = false
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

            BubbleViewLabel(goalId: goalId, focusGoal: $focusGoal, width: width, height: height, offset: offset, shouldShowDetails: shouldShowDetails, shouldShowStatusLabel: shouldShowStatusLabel, ignoreImageLoad: ignoreImageLoad, ignoreImageRefresh: ignoreImageRefresh)
            
                
        }
        .buttonStyle(.plain)

    }
}

struct BubbleView_Previews: PreviewProvider {
    static var previews: some View {
        BubbleView(goalId: UUID(), focusGoal: .constant(UUID()), width: 3)
            .environmentObject(ViewModel())
    }
}
