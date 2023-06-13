//
//  SetupCreed.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/8/23.
//

import SwiftUI

struct SetupCreed: View {
    @Binding var canProceed: Bool
    
    var body: some View {
        CreedCardList()
            .padding([.top,.bottom],8)
            .modifier(ModifierForm())
            .onAppear(){
                canProceed = true
            }
    }
}

struct SetupCreed_Previews: PreviewProvider {
    static var previews: some View {
        SetupCreed(canProceed: .constant(false))
    }
}
