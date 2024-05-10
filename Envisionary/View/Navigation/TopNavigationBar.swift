//
//  TopNavigationBar.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/9/23.
//

import SwiftUI

struct TopNavigationBar: View {
    @EnvironmentObject var vm: ViewModel
    @Binding var shouldShowTopTitle: Bool
    @Binding var isPresentingSetup: Bool
    @Binding var modalType: ModalType
    @State var shouldMoveDateForward = false
    @State var shouldMoveDateBackward = false
    var body: some View {
        
            HStack{
                Spacer()
                
                if shouldShowTopTitle {
                    HStack{
                        
                        if ShouldShowObjectString(){
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
//                IconButton(isPressed: $shouldPresentSetup, size: .medium, iconType: .help, iconColor: .grey10)
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
    
    func ShouldShowObjectString() -> Bool{
        
        if vm.filtering.filterObject == .goal && vm.filtering.filterIncludeCalendar{
            return false
        }
        
        if vm.filtering.filterObject == .journal && vm.filtering.filterIncludeCalendar && vm.filtering.filterEntry{
            return false
        }
        
        return true
    }
    
    func GetOpacity() -> CGFloat{
        
        if shouldShowTopTitle{
            return 1.0
        }
        else{
            return 0.0
        }
    }
    
    
}

struct TopNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        TopNavigationBar(shouldShowTopTitle: .constant(false), isPresentingSetup: .constant(false), modalType: .constant(.add))
            .environmentObject(ViewModel())
    }
}
