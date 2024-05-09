//
//  ProgressPoint.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/27/24.
//

import Foundation
struct ProgressPoint: Identifiable, Codable, Equatable, Hashable{
    let id: UUID
    var parentId: UUID
    var amount: Int
    var progress: Int
    var date: Date
    
    init(from entity: ProgressPointEntity){
        self.id = entity.id ?? UUID()
        self.amount = Int(entity.amount)
        self.parentId = entity.parentId ?? UUID()
        self.progress = Int(entity.progress)
        self.date = entity.date ?? Date()
    }
    
    init(date: Date, progress: Int){
        id = UUID()
        parentId = UUID()
        self.progress = progress
        self.date = date
        amount = 0
    }
    
    init(){
        id = UUID()
        parentId = UUID()
        amount = 0
        progress = 0
        date = Date()
    }
}
