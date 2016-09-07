//
//  Deserializer.swift
//  Serializer
//
//  Created by Luciano Almeida on 9/3/16.
//  Copyright © 2016 Luciano Almeida. All rights reserved.
//

import UIKit

public class Deserializer <T: Serializable>: NSObject {

    public class func objects(jsonData: NSData) -> [T]? {
        if let jsonArray = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as? [[String: AnyObject]], let unwrappedArray = jsonArray{
            return objects(unwrappedArray)
        }
        return nil
    }
    
    public class func object(jsonData: NSData) -> T? {
        if let json = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: NSJSONReadingOptions.MutableContainers) as? [String: AnyObject], let unwrappedJson = json{
            return object(unwrappedJson)
        }
        return nil
    }
    
    public class func objects(jsonArray: [[String : AnyObject]]) -> [T] {
        return jsonArray.map({object($0)})
    }
    
    public class func object(json: [String: AnyObject]) -> T {
        return T(decoder: SerializerDecoder(properties: json))
        
    }
    
    
    
}
