//
//  EnvisionaryApp.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/7/23.
//

import SwiftUI

@main
struct EnvisionaryApp: App {
    @StateObject private var vm = ViewModel(fillData: true)
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
//                .onAppear{
//                    GetAllFonts()
//                }
        }
    }
    
    func GetAllFonts(){
        for family: String in UIFont.familyNames
        {
            print(family)
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
    }
}
