////
////  UpdateTaskRequest.swift
////  Envisionary
////
////  Created by Campbell McGavin on 4/9/23.
////
//
//import SwiftUI
//
//struct UpdateTaskRequest {
//
//    var title: String
//    var description: String
//    var startDate: Date
//    var endDate: Date
//    var progress: Int
//
//    init(title: String, description: String, startDate: Date, endDate: Date, progress: Int)
//    {
//        self.title = title
//        self.description = description
//        self.startDate = startDate
//        self.endDate = endDate
//        self.progress = progress
//    }
//
//    init(properties: Properties){
//        self.title = properties.title ?? ""
//        self.description = properties.description ?? ""
//        self.startDate = properties.startDate ?? Date()
//        self.endDate = properties.endDate ?? Date()
//        self.progress = properties.progress ?? 0
//    }
//}
