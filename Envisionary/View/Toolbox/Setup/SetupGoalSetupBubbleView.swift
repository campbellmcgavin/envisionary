//
//  SetupGoalSetupBubbleView.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/12/23.
//

import SwiftUI

struct SetupGoalSetupBubbleView: View {
    @Binding var goalRequest: CreateGoalRequest
    @Binding var shouldAdd: Bool
    @EnvironmentObject var vm: ViewModel
    
    @State var shouldSave: Bool = false
    @State var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Button{
//            withAnimation{
            shouldAdd.toggle()
//            }
        }

    label:{
        HStack{
            
                IconLabel(size: .medium, iconType: .confirm, iconColor: shouldSave ? .green : .grey5)
            
                VStack(alignment:.leading){
                    Text(goalRequest.title)
                        .font(.specify(style: .caption))
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.specify(color: .grey10))
                    Text(goalRequest.timeframe.toString())
                        .textCase(.uppercase)
                        .font(.specify(style: .subCaption))
                        .multilineTextAlignment(.leading)
                }
                Spacer()

            }
            .padding(7)
            .modifier(ModifierCard(color: .grey3))
            .frame(width:150, height:50)
    }
    .buttonStyle(.plain)
    }
}

struct SetupGoalSetupBubbleView_Previews: PreviewProvider {
    static var previews: some View {
        SetupGoalSetupBubbleView(goalRequest: .constant(CreateGoalRequest(properties: Properties())), shouldAdd: .constant(false))
    }
}
