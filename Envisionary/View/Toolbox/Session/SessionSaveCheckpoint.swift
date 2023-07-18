//
//  SessionSaveCheckpoint.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/12/23.
//

import SwiftUI

struct SessionSaveCheckpoint: View {
    @Binding var shouldSave: Bool
    
    var body: some View {
        VStack{
            TextButton(isPressed: $shouldSave, text: shouldSave ? "Saved" : "Save", color: shouldSave ? .grey7 : .grey0, backgroundColor: shouldSave ? .grey3 : .grey10, style: .h3, shouldHaveBackground: true)
                .padding([.leading,.trailing],-8)
//                .padding(.top)
                .disabled(shouldSave)
        }
    }
}

struct SessionSaveCheckpoint_Previews: PreviewProvider {
    static var previews: some View {
        SessionSaveCheckpoint(shouldSave: .constant(false))
    }
}
