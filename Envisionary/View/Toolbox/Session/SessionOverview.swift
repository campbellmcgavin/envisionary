//
//  SessionOverview.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/11/23.
//

import SwiftUI

struct SessionOverview: View {
    
    var body: some View {
        
        VStack{
            ForEach(SessionStepType.allCases.map({$0}), id:\.self){ step in
                if step != .overview {
                    FormLabel(fieldValue: step.toString(), fieldName: "Step " + String(step.toStepNumber()), iconType: step.toIcon())
                }
            }
        }

    }
}

struct SessionOverview_Previews: PreviewProvider {
    static var previews: some View {
        SessionOverview()
    }
}
