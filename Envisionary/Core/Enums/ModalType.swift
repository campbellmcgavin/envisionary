//
//  ModalType.swift
//  Envisionary
//
//  Created by Campbell McGavin on 3/17/23.
//

enum ModalType{
    
    case add
    case search
    case settings
    case filter
    case notifications
    case help
    case edit
    case delete
    case photoSource
    case photo
    case feedback
//    case setup
    
    
    func ShouldShowImage(objectType: ObjectType) -> Bool {
        switch self {
        case .add:
            return objectType.ShouldShowImage()
        case .search:
            return false
        case .settings:
            return false
        case .filter:
            return false
        case .notifications:
            return false
        case .help:
            return false
        case .edit:
            return objectType.ShouldShowImage()
        case .delete:
            return false
        case .photoSource:
            return false
        case .photo:
            return objectType.ShouldShowImage()
        case .feedback:
            return false
//        case .setup:
//            return false
        }
    }
}
