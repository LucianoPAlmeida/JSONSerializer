//
//  Serializer.swift
//  Serializer
//
//  Created by Luciano Almeida on 9/3/16.
//  Copyright © 2016 Luciano Almeida. All rights reserved.
//

import Foundation


open class Serializer<T: Serializable>: NSObject {

    open class func JSONData(_ objects: [T] ) -> Data?{
        let objectsData = NSMutableData()
        for object in objects {
            if let data = JSONData(object) {
                objectsData.append(data)
            }
        }
        return objectsData as Data
    }
    
    open class func JSONData(_ object: T) -> Data? {
        let json = keyValueObject(object)
        do{
            return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
        }catch {
            return nil
        }
        
    }
    
    open class func keyValueObjects(_ array: [T]) -> [[String : Any]] {
        return array.map({keyValueObject($0)})
    }
    
    open class func keyValueObject(_ object: T) -> [String: Any]{
        let encoder = SerializerEncoder()
        object.encode(encoder)
        return encoder.properties
    }
    
}
