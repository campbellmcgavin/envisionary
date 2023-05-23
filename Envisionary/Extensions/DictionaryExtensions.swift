//
//  DictionaryExtensions.swift
//  Envisionary
//
//  Created by Campbell McGavin on 5/14/23.
//

import SwiftUI

extension Dictionary where Key: NSObject, Value:AnyObject {

    var jsonString:String {

        do {
            let stringData = try JSONSerialization.data(withJSONObject: self as NSDictionary, options: JSONSerialization.WritingOptions.prettyPrinted)
            if let string = String(data: stringData, encoding: String.Encoding(rawValue: NSUTF8StringEncoding) ){
                return string
            }
        }catch _ {

        }
        return ""
    }
}
