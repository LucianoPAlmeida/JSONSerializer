//
//  Deserializer.swift
//  Serializer
//
//  Created by Luciano Almeida on 9/3/16.
//  Copyright © 2016 Luciano Almeida. All rights reserved.
//

import Foundation

open class Deserializer <T: Serializable>: NSObject {

    open class func objects(_ jsonData: Data) -> [T]? {
        if let jsonArray = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [[String: AnyObject]], let unwrappedArray = jsonArray{
            return objects(unwrappedArray)
        }
        return nil
    }
    
    open class func object(_ jsonData: Data) -> T? {
        if let json = try? JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: AnyObject], let unwrappedJson = json{
            return object(unwrappedJson)
        }
        return nil
    }
    
    open class func objects(_ jsonArray: [[String : AnyObject]]) -> [T] {
        return jsonArray.map({object($0)})
    }
    
    open class func object(_ json: [String: AnyObject]) -> T {
        return T(decoder: SerializerDecoder(properties: json))
        
    }
    
    
    
}
