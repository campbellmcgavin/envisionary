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
    
    
    @EnvironmentObject var alerts: AlertsService
    
    var body: some View {

        if isVisible {
            
            HStack{
                
                Button{
                    withAnimation{
                        isPressed.toggle()
                    }
                }
            label:{
                Text(alert.keyword)
                    .font(.specify(style: alert.keyword.count > 12 ? .caption : .h6))
                    .padding(3)
                    .padding([.leading,.trailing],3)
                    .background(Capsule()
                        .foregroundColor(.specify(color: alert.alertType.GetForegroundColor()))
                        .opacity(0.2))
                    .padding(.leading,-5)
                Text(alert.description)
                    .multilineTextAlignment(.leading)
                    .font(.specify(style: .h6))
                    .padding([.top,.bottom],8)
                Spacer()
            }
                
                
                
                Button{
                    withAnimation{
                        if isPressed{
                            alerts.alerts.removeAll(where: {$0 == alert})
                        }
                        else{
                            isPressed.toggle()
                        }
                    }
                }
            label:{
                
                if isPressed{
                    IconLabel(size: .small, iconType: .cancel, iconColor: alert.alertType.GetForegroundColor())
                }
                else{
                    ZStack{
                        Countdown(counter: $counter, shouldReset: .constant(false), timeAmount: alert.timeAmount, color: alert.alertType.GetForegroundColor(), size: .extraSmall, shouldCountDown: !alert.isPersistent, shouldShowClock: false)
                        IconLabel(size: .small, iconType: alert.alertType.GetIcon(), iconColor: alert.alertType.GetForegroundColor())
                    }
                }
                }
            }
            .padding([.leading])
            .padding(.trailing,8)
            .background(Color.specify(color: alert.alertType.GetForegroundColor()).opacity(0.2))
            .foregroundColor(.specify(color: alert.alertType.GetForegroundColor()))
            .modifier(ModifierSmallCard(opacity:0.2))
            
            .onChange(of: counter){ _ in
                if counter < 0.2 {
                    withAnimation{
                        isVisible = false
                        alerts.alerts.removeAll(where: {$0 == alert})
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
            .environmentObject(ViewModel())
    }
}
