////
////  TestDataService.swift
////  EnvisionaryTests
////
////  Created by Campbell McGavin on 6/1/23.
////
//
//import SwiftUI
//
//import CoreData
//
//class TestDataService: DataService {
//  override init() {
//    super.init()
//
//    // 1
//    let persistentStoreDescription = NSPersistentStoreDescription()
//    persistentStoreDescription.type = NSInMemoryStoreType
//
//    // 2
//    let container = NSPersistentContainer(
//      name: CoreDataStack.modelName,
//      managedObjectModel: CoreDataStack.model)
//
//    // 3
//    container.persistentStoreDescriptions = [persistentStoreDescription]
//
//    container.loadPersistentStores { _, error in
//      if let error = error {
//        fatalError("Unresolved error \(error), \(error.userInfo)")
//      }
//    }
//
//    // 4
//    container = container
//  }
//}
