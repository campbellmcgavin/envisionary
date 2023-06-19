//
//  SessionEntry.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/14/23.
//

import SwiftUI

struct SessionEntry: View {
    @State var properties = Properties()
    @State var isValidForm = false
    @State var shouldAddEntry = false
    @State var didAttemptToSave = false
    @State var didSave = false
    @EnvironmentObject var vm: ViewModel
    
    var body: some View {
        VStack{
            HStack{
                Text("New journal entry")
                    .font(.specify(style: .h3))
                    .foregroundColor(.specify(color: .grey10))
                    .frame(alignment:.leading)
                    .padding(.top)
                    .padding(.leading,8)
                Spacer()
            }

            
            if !didSave{
                FormPropertiesStack(properties: $properties, images: .constant([UIImage]()), isPresentingPhotoSource: .constant(false), isValidForm: $isValidForm, didAttemptToSave: $didAttemptToSave, objectType: .entry, modalType: .add)
            }
            TextButton(isPressed: $shouldAddEntry, text: didSave ? "Entry added" : "Add entry", color: .grey0, backgroundColor: (!isValidForm && didAttemptToSave) || didSave ? .grey3 : .grey10, style: .h3, shouldHaveBackground: true)
                .padding(.top)
        }
        .onChange(of: shouldAddEntry){
            _ in
            
            if isValidForm && !didSave{
                let request = CreateEntryRequest(properties: properties)
                _ = vm.CreateEntry(request: request)
                withAnimation{
                    didSave = true
                }
            }
            didAttemptToSave = true
            
        }
    }
}

struct SessionEntry_Previews: PreviewProvider {
    static var previews: some View {
        SessionEntry()
    }
}
