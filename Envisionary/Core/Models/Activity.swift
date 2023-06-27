//
//  Activity.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/24/23.
//

import SwiftUI

struct Activity {
    let id: UUID
    var keyword: String
    
    init(from entity: ActivityEntity?){
        
        self.id = entity?.id ?? UUID()
        self.keyword = entity?.keyword ?? ""
    }
}
