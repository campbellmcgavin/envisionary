//
//  TutorialPermissions.swift
//  Envisionary
//
//  Created by Campbell McGavin on 8/3/23.
//

import SwiftUI

struct TutorialPermissions: View {
    @Binding var canProceed: Bool
    
    @State var shouldRequestPermissions: Bool = false
    @State var didAcceptNotifcations = false
    
    var body: some View {
        
        TextIconButton(isPressed: $shouldRequestPermissions, text: canProceed ? (didAcceptNotifcations ? "Notifications Enabled" : "Notifications Disabled") : "Notifications Preferences", color: .grey0, backgroundColor: canProceed ? (didAcceptNotifcations ? .green : .red) : .grey10, fontSize: .h3, shouldFillWidth: true)
            .padding([.top,.bottom],8)
            .disabled(canProceed)
            .opacity(canProceed ? 0.3 : 1.0)
            .onChange(of: shouldRequestPermissions){
                _ in
                EnablePermissions()
            }
        
//        TextIconButton(isPressed: $shouldRequestPermissions, text: "No thanks", color: .grey0, backgroundColor: canProceed ? (didAcceptNotifcations ? .green : .red) : .grey10, fontSize: .h3, shouldFillWidth: true)
//            .padding([.top,.bottom],8)
//            .disabled(canProceed)
//            .opacity(canProceed ? 0.3 : 1.0)
//            .onChange(of: shouldRequestPermissions){
//                _ in
//                EnablePermissions()
//            }
    }
    
    func EnablePermissions(){
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                didAcceptNotifcations = true
                canProceed = true
                UserDefaults.standard.set(true, forKey: SettingsKeyType.notification_entry.toString())
                UserDefaults.standard.set(true, forKey: SettingsKeyType.notification_value_align.toString())
                UserDefaults.standard.set(true, forKey: SettingsKeyType.notification_digest.toString())
            } else if let error = error {
                print(error.localizedDescription)
                canProceed = true
                UserDefaults.standard.set(false, forKey: SettingsKeyType.notification_entry.toString())
                UserDefaults.standard.set(false, forKey: SettingsKeyType.notification_value_align.toString())
                UserDefaults.standard.set(false, forKey: SettingsKeyType.notification_digest.toString())
            }
            
        }
    }
    
}

struct TutorialPermissions_Previews: PreviewProvider {
    static var previews: some View {
        TutorialPermissions(canProceed: .constant(false))
    }
}
