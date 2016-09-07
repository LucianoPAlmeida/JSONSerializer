//
//  Serializer.swift
//  Serializer
//
//  Created by Luciano Almeida on 9/3/16.
//  Copyright © 2016 Luciano Almeida. All rights reserved.
//

import Foundation


public class Serializer<T: Serializable>: NSObject {

    public class func JSONData(objects: [T] ) -> NSData?{
        let objectsData = NSMutableData()
        for object in objects {
            if let data = JSONData(object) {
                objectsData.appendData(data)
            }
        }
        return objectsData
    }
    
    public class func JSONData(object: T) -> NSData? {
        let json = keyValueObject(object)
        do{
            return try NSJSONSerialization.dataWithJSONObject(json, options: NSJSONWritingOptions.PrettyPrinted)
        }catch {
            return nil
        }
        
    }
    
    public class func keyValueObjects(array: [T]) -> [[String : AnyObject]] {
        return array.map({keyValueObject($0)})
    }
    
    public class func keyValueObject(object: T) -> [String: AnyObject]{
        let encoder = SerializerEncoder()
        object.encode(encoder)
        return encoder.properties
    }
    
}
