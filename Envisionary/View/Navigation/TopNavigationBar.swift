//
//  TopNavigationBar.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/9/23.
//

import SwiftUI

struct TopNavigationBar: View {
    @EnvironmentObject var vm: ViewModel
    @Binding var offset: CGFloat
    @Binding var isPresentingMainMenu: Bool
    @State var shouldMoveDateForward = false
    @State var shouldMoveDateBackward = false
    var body: some View {
        
            HStack{
//                IconButton(isPressed: $isPresentingMainMenu, size: .medium, iconType: .hambugerMenu, iconColor: .grey10)
                Spacer()
                
                if offset > 0 {
                    HStack{
                        
                        if vm.filtering.filterObject == .home || vm.filtering.filterObject == .aspect || vm.filtering.filterObject == .value || vm.filtering.filterObject == .creed || vm.filtering.filterObject == .chapter || vm.filtering.filterObject == .dream{
                            Text(vm.filtering.filterObject.toPluralString())
                                .font(.specify(style: .h4))
                        }
                        else{
                            IconButton(isPressed: $shouldMoveDateBackward, size: .extraSmall, iconType: .left, iconColor: .grey7, hasAnimation: true)
                                .padding(.trailing,6)
                            
                                VStack(spacing:0){
                                    Text(vm.filtering.filterTimeframe.toString() + " " + vm.filtering.filterObject.toPluralString())
                                        .font(.specify(style:.subCaption))
                                        .textCase(.uppercase)
                                        .opacity(0.5)
                                    HStack(spacing:0){
                                        Text(vm.filtering.filterDate.toString(timeframeType: vm.filtering.filterTimeframe))
                                            .font(.specify(style: .h4))
                                        DateResetButton()
                                            .scaleEffect(0.7)
                                            .disabled(true)
                                            .offset(x: 7)
                                            .frame(width:12, height:0)
                                    }
                                }
                                .frame(alignment:.center)
                                .onTapGesture {
                                    withAnimation{
                                        vm.pushToToday = true
                                        vm.filtering.filterDate = Date()
                                    }
                                }
                                    
                            

                            
                            
                            IconButton(isPressed: $shouldMoveDateForward, size: .extraSmall, iconType: .right, iconColor: .grey7, hasAnimation: true)
                                .padding(.leading,6)

                        }
                        
                    }
                    .foregroundColor(.specify(color: .grey10))
                    .opacity(GetOpacity())
                }
                
                Spacer()
//                IconButton(isPressed: $isPresentingMainMenu, size: .medium, iconType: .help, iconColor: .grey10)
            }
            .padding([.leading,.trailing],8)
            .frame(height:40)
            .padding(.top,-5)
            .padding(.bottom,5)
            .background(Color.specify(color: .purple))
            .onChange(of:shouldMoveDateForward){
                _ in
                if shouldMoveDateForward{
                    vm.filtering.filterDate = vm.filtering.filterDate.AdvanceDate(timeframe: vm.filtering.filterTimeframe, forward: true)
                }
                shouldMoveDateForward = false
            }
            .onChange(of:shouldMoveDateBackward){
                _ in
                if shouldMoveDateBackward{
                    vm.filtering.filterDate = vm.filtering.filterDate.AdvanceDate(timeframe: vm.filtering.filterTimeframe, forward: false)
                }
                shouldMoveDateBackward = false
            }
        
    }
    
    func GetOpacity() -> CGFloat{
        if offset > 0 && offset < 110 {
            return abs(((1.0 * offset/110)))
        }
        return 1.0
    }
    
    
}

struct TopNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        TopNavigationBar(offset: .constant(0), isPresentingMainMenu: .constant(false))
            .environmentObject(ViewModel())
    }
}
