//
//  InterfaceTriggers.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/16/23.
//

import SwiftUI

struct InterfaceTriggers {
    var shouldPresentModal: Bool

    init(){
        shouldPresentModal = false
    }

    static func == (lhs: InterfaceTriggers, rhs: InterfaceTriggers) -> Bool {

        let isEqual = lhs.shouldPresentModal == rhs.shouldPresentModal

        return isEqual
    }
}
