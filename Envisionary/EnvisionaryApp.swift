//
//  EnvisionaryApp.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/7/23.
//

import SwiftUI

@main
struct EnvisionaryApp: App {
    @StateObject private var vm = ViewModel()
    let keyInputSubject = KeyInputSubjectWrapper()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
                .environmentObject(keyInputSubject)
            .environment(\.font, .specify(style: .h6))
        }
        
        .commands {
            CommandMenu("Input") {
                keyInput(.leftArrow)
                keyInput(.rightArrow)
                keyInput(.upArrow)
                keyInput(.downArrow)
                keyInput(.space)
                keyInput(.delete)
                keyInput(.return)
            }
        }
        
    }
    
//    func GetAllFonts(){
//        for family: String in UIFont.familyNames
//        {
//            print(family)
//            for names: String in UIFont.fontNames(forFamilyName: family)
//            {
//                print("== \(names)")
//            }
//        }
//    }
}
