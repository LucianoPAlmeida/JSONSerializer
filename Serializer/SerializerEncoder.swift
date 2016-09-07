//
//  SerializerEncoder.swift
//  Serializer
//
//  Created by Luciano Almeida on 9/3/16.
//  Copyright © 2016 Luciano Almeida. All rights reserved.
//

import Foundation

public class SerializerEncoder: NSObject {
    private(set) var properties: [String: AnyObject] = [:]
    
    
    
    public func encodeInteger(intValue: Int, forKey key: String){
        return properties[key] = intValue
    }
    
    public func encodeDouble(doubleValue: Double, forKey key: String){
        return properties[key] = doubleValue
    }
    
    public func encodeLong(number: NSNumber, forKey key: String){
        return properties[key] = number
    }
    
    public func encodeString(string: String, forKey key: String) {
        return properties[key] = string
    }
    
    
    public func encodeSerializableObject<T: Serializable>(object: T,forKey key: String){
        let encoder = SerializerEncoder()
        object.encode(encoder)
        properties.updateValue(encoder.properties, forKey: key)
    }
    
    
    public func encodeSerializableObjectArray<T: Serializable>(objects: [T],forKey key: String){
        let values = objects.map { (object) -> SerializerEncoder in
            let encoder = SerializerEncoder()
            object.encode(encoder)
            return encoder
        }.map({$0.properties})
        properties.updateValue(values, forKey: key)
    }
    
    
    public func encodeDoubleArray(doubleArray: [Double], forKey key: String){
        properties[key] = doubleArray
    }
    
    public func encodeIntArray(intArray: [Int], forKey key: String){
        return properties[key] = intArray
    }
    
    public func encodeStringArray(stringArray: [String], forKey key: String){
        return properties[key] = stringArray
    }
    
    public func encodeObject<K,T>(object: T ,forKey key: String, withDataTransformer transformer: DataTransformer<T,K>){
        if let anyObjc = transformer.toJSON(object) as? AnyObject {
            properties.updateValue(anyObjc, forKey: key)
        }
    }
}
