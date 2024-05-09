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
    @State var didStartup = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
                .onAppear{
                    if !didStartup {
                        vm.CleanupDuplicates()
                        didStartup = true
                    }
                    
                }
                .onAppear(){
                    ArchetypeType.allCases.forEach({
                        
                        type in
                        
                        print( ExampleGoalEnum.toTitleArray(archetype: type))
                    })
                    
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
