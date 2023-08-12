//
//  FormPropertiesValidator.swift
//  Envisionary
//
//  Created by Campbell McGavin on 6/2/23.
//

import SwiftUI

class FormPropertiesValidator: ObservableObject {
    @Published var isDirty: Bool = false
    
    @Published var title = FormPropertyValidator(propertyType: .title)
    @Published var timeframe = FormPropertyValidator(propertyType: .timeframe)
    @Published var startDate = FormPropertyValidator(propertyType: .startDate)
    @Published var endDate = FormPropertyValidator(propertyType: .endDate)
    @Published var aspect = FormPropertyValidator(propertyType: .aspect)
    @Published var priority = FormPropertyValidator(propertyType: .priority)
    @Published var chapter = FormPropertyValidator(propertyType: .chapter)
    @Published var scheduleType = FormPropertyValidator(propertyType: .scheduleType)
    @Published var unit = FormPropertyValidator(propertyType: .unit)
    @Published var amount = FormPropertyValidator(propertyType: .amount)
    
    func isValidForm() -> Bool{
        return title.isValid &&
        timeframe.isValid &&
        startDate.isValid &&
        endDate.isValid &&
        aspect.isValid &&
        priority.isValid &&
        chapter.isValid &&
        scheduleType.isValid &&
        unit.isValid &&
        amount.isValid
    }
    
    func reset(){
        title = FormPropertyValidator(propertyType: .title)
        timeframe = FormPropertyValidator(propertyType: .timeframe)
        startDate = FormPropertyValidator(propertyType: .startDate)
        endDate = FormPropertyValidator(propertyType: .endDate)
        aspect = FormPropertyValidator(propertyType: .aspect)
        priority = FormPropertyValidator(propertyType: .priority)
        chapter = FormPropertyValidator(propertyType: .chapter)
        scheduleType = FormPropertyValidator(propertyType: .scheduleType)
        unit = FormPropertyValidator(propertyType: .unit)
        amount = FormPropertyValidator(propertyType: .amount)
        isDirty = false
    }
    
    func validateForm(properties: Properties, objectType: ObjectType){
        
        if objectType.hasProperty(property: .title){
            title.isValid = properties.isValid(propertyType: .title, objectType: objectType)
            title.error = title.isValid ? nil : properties.getFormError(propertyType: .title)
        }
        
        if objectType.hasProperty(property: .timeframe){
            timeframe.isValid = properties.isValid(propertyType: .timeframe, objectType: objectType)
            timeframe.error = timeframe.isValid ? nil : properties.getFormError(propertyType: .timeframe)
        }
        
        if objectType.hasProperty(property: .aspect){
            aspect.isValid = properties.isValid(propertyType: .aspect, objectType: objectType)
            aspect.error = aspect.isValid ? nil : properties.getFormError(propertyType: .aspect)
        }
        
        if objectType.hasProperty(property: .priority){
            priority.isValid = properties.isValid(propertyType: .priority, objectType: objectType)
            priority.error = priority.isValid ? nil : properties.getFormError(propertyType: .priority)
        }
        
        if objectType.hasProperty(property: .startDate){
            startDate.isValid = properties.isValid(propertyType: .startDate, objectType: objectType)
            startDate.error = startDate.isValid ? nil : properties.getFormError(propertyType: .startDate)
        }
        
        if objectType.hasProperty(property: .endDate){
            endDate.isValid = properties.isValid(propertyType: .endDate, objectType: objectType)
            endDate.error = endDate.isValid ? nil : properties.getFormError(propertyType: .endDate)
        }
        
        if objectType.hasProperty(property: .chapter){
            chapter.isValid = properties.isValid(propertyType: .chapter, objectType: objectType)
            chapter.error = chapter.isValid ? nil : properties.getFormError(propertyType: .chapter)
        }
        
        if objectType.hasProperty(property: .scheduleType){
            scheduleType.isValid = properties.isValid(propertyType: .scheduleType, objectType: objectType)
            scheduleType.error = scheduleType.isValid ? nil : properties.getFormError(propertyType: .scheduleType)
        }
        
        if objectType.hasProperty(property: .unit){
            unit.isValid = properties.isValid(propertyType: .unit, objectType: objectType)
            unit.error = unit.isValid ? nil : properties.getFormError(propertyType: .unit)
        }
        
        if objectType.hasProperty(property: .amount){
            amount.isValid = properties.isValid(propertyType: .amount, objectType: objectType)
            amount.error = amount.isValid ? nil : properties.getFormError(propertyType: .amount)
        }
    }
}



struct FormPropertyValidator {
    var isDirty = false
    var isValid = true
    var error: FormErrorType? = nil
    let propertyType: PropertyType
    
    init(propertyType: PropertyType) {
        self.propertyType = propertyType
    }
}

enum FormErrorType{
    case fieldIsTooShort
    case fieldCannotBeEmpty
    case fieldIsTooLong
    case fieldCannotBeZero
    case fieldCannotBeBefore
    func toString(propertyType: PropertyType) -> String{
        switch self {
        case .fieldIsTooShort:
            return propertyType.toString() + " is too short."
        case .fieldCannotBeEmpty:
            return propertyType.toString() + " cannot be empty."
        case .fieldIsTooLong:
            return propertyType.toString() + " is too long."
        case .fieldCannotBeZero:
            return propertyType.toString() + " cannot be zero."
        case .fieldCannotBeBefore:
            return propertyType.toString() + " cannot be before start date."
        }
    }
}
