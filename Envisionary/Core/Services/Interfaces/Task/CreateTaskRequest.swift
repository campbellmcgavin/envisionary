//
//  CreateTaskRequest.swift
//  Envisionary
//
//  Created by Campbell McGavin on 4/9/23.
//

import SwiftUI

struct CreateTaskRequest {
    var title: String
    var description: String
    var startDate: Date
    var endDate: Date
    

    init(title: String, description: String, startDate: Date, endDate: Date)
    {
        self.title = title
        self.description = description
        self.startDate = startDate
        self.endDate = endDate
    }
    
    init(properties: Properties){
        self.title = properties.title ?? ""
        self.description = properties.description ?? ""
        self.startDate = properties.startDate ?? Date()
        self.endDate = properties.endDate ?? Date()
    }
}
