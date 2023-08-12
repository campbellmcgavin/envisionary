//
//  SetupTemplate.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/9/23.
//

import SwiftUI

struct SetupTemplate<Content: View>: View {
    @Binding var canProceed: Bool
    @Binding var bumpScrollView: Bool
    let textArray: [String]
    @ViewBuilder var content: Content
    var shouldShowCard: Bool = true
    @State var counter: Double = 0.0
    @State private var timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()
    @State var timeStamps: [Double] = [Double]()
    @State var shouldShowIndex = 0
    @State var finishLoad = false
    var body: some View {
        
        let transition = AnyTransition.asymmetric(insertion: .move(edge: .leading), removal: .opacity)
        
        VStack{
            ForEach(Array(textArray.enumerated()), id:\.element){index, element in
                
                if index < shouldShowIndex || finishLoad{
                    Text(element)
                        .foregroundColor(.specify(color: .grey9))
                        .font(.specify(style: .h5))
                        .frame(maxWidth:.infinity, alignment:.leading)
                        .padding()
                        .modifier(ModifierForm(color:.grey15))
                        .transition(transition)
                }
            }
            
            if shouldShowIndex > textArray.count || finishLoad {
                content
                    .transition(transition)
                    .modifier(ModifierForm(color: shouldShowCard ? .grey15 : .clear))
            }
            else if !finishLoad{
                HStack{

                    MessageBubble(shouldShow: .constant(true))
                        .transition(transition)
                

                    Spacer()
                }
            }
        }
        .onTapGesture(perform: {
            withAnimation{
                finishLoad = true
            }
        })
        .onAppear{
            counter = 0
            timeStamps = [Double]()
            timeStamps.append(Double.random(in: 2.25...3.25))
            
            for text in textArray {
                let wordCount = Double(text.split(separator: " ").count)
                let lastTimestamp = timeStamps.last ?? 0.0
                var wordCountAmount = wordCount * 0.24
                
                if wordCountAmount < 1 {
                    wordCountAmount = Double.random(in: 0.6...1.3)
                }
                let multiply = lastTimestamp + wordCountAmount
                
                timeStamps.append( multiply)
            }
            timeStamps.append(Double.random(in: 3.0...4.0))
        }
        .onChange(of: counter){ _ in
            if (timeStamps.count > shouldShowIndex) && timeStamps[shouldShowIndex] <= counter {
                withAnimation{
                    shouldShowIndex += 1
                    bumpScrollView.toggle()
                }
            }
        }
        .onChange(of: shouldShowIndex){
            _ in
            if shouldShowIndex >= timeStamps.count - 1{
                canProceed = true
            }
        }
        .onChange(of: finishLoad){
            _ in
            canProceed = true
        }
        .onReceive(timer, perform: {_ in counter += 0.2})
    }
}
