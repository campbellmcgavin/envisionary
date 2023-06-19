//
//  SetupEntry.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/12/23.
//

import SwiftUI

struct SetupEntry: View {
    
    @Binding var canProceed: Bool
    
    @EnvironmentObject var vm: ViewModel
    @State var properties = Properties()
    @State var shouldAdd = false
    @State var shouldShowButton = true
    var body: some View {
        
        VStack{
            VStack{
                HStack{
                    IconLabel(size: .mediumLarge, iconType: .entry, iconColor: .grey9, circleColor: .grey4)
                        .padding(.trailing,8)
                    Text(properties.title ?? "")
                        .font(.specify(style: .h5))
                        .foregroundColor(.specify(color: .grey10))
                    Spacer()
                }
                .padding(.bottom,8)
                Text(properties.description ?? "")
                    .font(.specify(style: .h5))
                    .foregroundColor(.specify(color: .grey10))
                    .multilineTextAlignment(.leading)
            }
            .padding()
            .padding(.bottom)
            
            TextButton(isPressed: $shouldAdd, text: shouldShowButton ? "Add entry" : "Added", color: .grey10, backgroundColor: shouldShowButton ? .green : .grey5, style:.h3, shouldHaveBackground: true, shouldFill: true)
                .disabled(!shouldShowButton)
            
        }
        .padding(.bottom,8)
        .onAppear(){
            properties.title = "A day to remember!"
            properties.description = "Today is the day I downloaded Envisionary! I was able to learn some impressive tools that I am going to put into practice. I'm really excited because this is all going to contribute to me becoming the beautiful person that I know I can become."
            properties.chapterId = nil
        }
        .onChange(of: shouldAdd){
            _ in
            let request = CreateEntryRequest(properties: properties)
            _ = vm.CreateEntry(request: request)
            canProceed = true
            
            withAnimation{
                shouldShowButton = false
            }
        }
        
    }
}

struct SetupEntry_Previews: PreviewProvider {
    static var previews: some View {
        SetupEntry(canProceed: .constant(false))
    }
}
