//
//  AlertLabel.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/18/23.
//

import SwiftUI

struct AlertLabel: View {
    
    let alert: Alert
    @State var isPressed: Bool = false
    @State var isVisible = true
    @State var isRunningTimer = true
    @State var counter = 2.0
    
    
    @EnvironmentObject var dm: DataModel
    
    var body: some View {

        if isVisible {
            HStack{
                Text(alert.keyword)
                    .font(.specify(style:.h6))
                    .padding(3)
                    .padding([.leading,.trailing],3)
                    .background(Capsule()
                        .foregroundColor(.specify(color: alert.alertType.GetForegroundColor()))
                        .opacity(0.2))
                    .padding(.leading,-5)
                Text(alert.description)
                    .font(.specify(style: .h6))
                    .padding([.top,.bottom],8)
                
                Spacer()
                
                ZStack{
                    Countdown(counter: $counter, timeAmount: alert.timeAmount, color: alert.alertType.GetForegroundColor(), size: .extraSmall, shouldCountDown: true, shouldShowClock: false)
                    IconLabel(size: .small, iconType: alert.alertType.GetIcon(), iconColor: alert.alertType.GetForegroundColor())
                }

            }
            .padding([.leading])
            .padding(.trailing,8)
            .background(Color.specify(color: alert.alertType.GetForegroundColor()).opacity(0.15))
            .foregroundColor(.specify(color: alert.alertType.GetForegroundColor()))
            .modifier(ModifierSmallCard(opacity:0.2))
            
            .onChange(of: counter){ _ in
                if counter < 0.2 {
                    withAnimation{
                        isVisible = false
                    }
                }
            }
            .onAppear(){
                counter = Double(alert.timeAmount)
            }
        }
    }
    

    @ViewBuilder
    func BuildButton() -> some View {
        Text("Got it")
        
    }
    

}

struct AlertLabel_Previews: PreviewProvider {
    static var previews: some View {
        AlertLabel(alert: Alert())
            .environmentObject(DataModel())
    }
}
