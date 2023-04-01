//
//  EnvisionaryApp.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/7/23.
//

import SwiftUI

@main
struct EnvisionaryApp: App {
    @StateObject private var dm = DataModel()
    @StateObject private var gs = GoalService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dm)
                .environmentObject(gs)
                .onAppear{
                    GetAllFonts()
                }
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
