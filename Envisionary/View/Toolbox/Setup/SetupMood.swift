//
//  SetupMood.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/12/23.
//

import SwiftUI

struct SetupMood: View {
    
    @Binding var canProceed: Bool
    
    @EnvironmentObject var vm: ViewModel
    @State var properties = Properties()
    @State var shouldAdd = false
    @State var shouldShowButton = true
    var body: some View {
        
        VStack{
            VStack{
                HStack{
                    IconLabel(size: .mediumLarge, iconType: .emotion, iconColor: .purple, circleColor: .grey4)
                        .padding(.trailing,8)
                    VStack(alignment:.leading){
                        Text(properties.title ?? "")
                            .font(.specify(style: .h5))
                            .foregroundColor(.specify(color: .grey10))
                        Text(properties.startDate?.toString(timeframeType: .day) ?? "")
                            .font(.specify(style: .body2))
                            .lineLimit(1)
                            .foregroundColor(.specify(color: .grey6))
                        let emotionList = properties.emotionList?.map({$0.toString()}) ?? [String]()
                        
                        Text(emotionList.toCsvString())
                            .font(.specify(style: .subCaption))
                            .textCase(.uppercase)
                            .foregroundColor(.specify(color: .grey4))
                            .padding(.top,3)
                            .lineLimit(1)
                    }
                    Spacer()
                }
                .padding(8)
                .modifier(ModifierForm(color:.grey3))
                .padding(.bottom,8)
                
            }
            .padding()
            .padding(.bottom)
            
            TextButton(isPressed: $shouldAdd, text: shouldShowButton ? "Add mood" : "Added", color: .grey0, backgroundColor: shouldShowButton ? .grey10 : .grey5, style:.h3, shouldHaveBackground: true, shouldFill: true)
                .disabled(!shouldShowButton)
            
        }
        .padding(.bottom,8)
        .onAppear(){
            properties.title = "Check-in"
            properties.emotionalState = 4
            properties.emotionList = [.happiness, .contentment, .excitement]
            properties.startDate = Date()
        }
        .onChange(of: shouldAdd){
            _ in
            let request = CreateEmotionRequest(properties: properties)
            _ = vm.CreateEmotion(request: request)
            canProceed = true
            
            withAnimation{
                shouldShowButton = false
            }
        }
        
    }
}

struct SetupMood_Previews: PreviewProvider {
    static var previews: some View {
        SetupMood(canProceed: .constant(false))
    }
}
