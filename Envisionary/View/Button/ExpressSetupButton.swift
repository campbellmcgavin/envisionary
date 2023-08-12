//
//  ExpressSetupButton.swift
//  Envisionary
//
//  Created by Campbell McGavin on 7/3/23.
//

import SwiftUI

struct ExpressSetupButton: View {
    @Binding var isExpressSetup: Bool
    
    @State var shouldBeExpress: Bool = false
    @State var shouldNotBeExpress: Bool = false
    
    var body: some View {
        
        HStack{
//            TextButton(isPressed: $shouldBeExpress, text: "Express",  color:!isExpressSetup ? .grey0 : .grey1, backgroundColor: isExpressSetup ? .grey10 : .grey4, style:.h5, shouldHaveBackground: true, shouldFill: true, hasPadding: false)
//                .frame(maxWidth:.infinity)
//
//            TextButton(isPressed: $shouldNotBeExpress, text: "Custom", color: !isExpressSetup ? .grey0 : .grey0, backgroundColor: !isExpressSetup ? .grey10 : .grey4, style:.h5, shouldHaveBackground: true, shouldFill: true, hasPadding: false)
        }
        .onChange(of: shouldBeExpress){
            _ in
            isExpressSetup = true
        }
        .onChange(of: shouldNotBeExpress){
            _ in
            isExpressSetup = false
        }
    }
}

struct ExpressSetupButton_Previews: PreviewProvider {
    static var previews: some View {
        ExpressSetupButton(isExpressSetup: .constant(false))
    }
}
