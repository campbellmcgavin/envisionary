//
//  PickerWheelTextView.swift
//  Visionary
//
//  Created by Campbell McGavin on 3/24/22.
//

import SwiftUI

struct ScrollPickerTimeframeText: View {
    
    let timeframe: TimeframeType
    let width: CGFloat
    @Binding var selectionTimeframe: TimeframeType
    
    
    var body: some View {

        Text(timeframe.toString())
            .foregroundColor(.specify(color: .grey10))
            .font(.specify(style: .h6))
            .frame(width:width)
            .opacity(GetOpacity())
            .padding(.top,3)
    }
    
    func IsSelected() -> Bool{
        if timeframe.rawValue == selectionTimeframe.rawValue{
            return true
        }
        else{
            return false
        }
    }
    
    func GetOpacity() -> CGFloat{

        if IsSelected(){
            return 1
        }
        else{
            return 0.5
        }
    }
}

struct ScrollPickerText_Previews: PreviewProvider {
    static var previews: some View {
        ScrollPickerTimeframeText(timeframe: TimeframeType.day, width: 75, selectionTimeframe: .constant(.day))
    }
}
