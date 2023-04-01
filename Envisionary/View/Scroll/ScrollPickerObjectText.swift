//
//  PickerWheelTextView.swift
//  Visionary
//
//  Created by Campbell McGavin on 3/24/22.
//

import SwiftUI

struct ScrollPickerObjectText: View {
    
    let object: ObjectType
    let width: CGFloat
    @Binding var selectionObject: ObjectType
    
    
    var body: some View {

        Text(object.toPluralString())
            .foregroundColor(.specify(color: .grey10))
            .font(.specify(style: .h6))
            .frame(width:width)
            .opacity(GetOpacity())
            .padding(.top,3)
    }
    
    func IsSelected() -> Bool{
        if object.rawValue == selectionObject.rawValue{
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

struct ScrollPickerObjectText_Previews: PreviewProvider {
    static var previews: some View {
        ScrollPickerObjectText(object: ObjectType.home, width: 75, selectionObject: .constant(.home))
    }
}
