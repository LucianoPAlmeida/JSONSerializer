//
//  SerializerEncoder.swift
//  Serializer
//
//  Created by Luciano Almeida on 9/3/16.
//  Copyright © 2016 Luciano Almeida. All rights reserved.
//

import Foundation

open class SerializerEncoder: NSObject {
    fileprivate(set) var properties: [String: AnyObject] = [:]
    
    
    
    open func encodeInteger(_ intValue: Int, forKey key: String){
        return properties[key] = intValue as AnyObject?
    }
    
    open func encodeDouble(_ doubleValue: Double, forKey key: String){
        return properties[key] = doubleValue as AnyObject?
    }
    
    open func encodeLong(_ number: NSNumber, forKey key: String){
        return properties[key] = number
    }
    
    open func encodeString(_ string: String, forKey key: String) {
        return properties[key] = string as AnyObject?
    }
    
    
    open func encodeSerializableObject<T: Serializable>(_ object: T,forKey key: String){
        let encoder = SerializerEncoder()
        object.encode(encoder)
        properties.updateValue(encoder.properties as AnyObject, forKey: key)
    }
    
    
    open func encodeSerializableObjectArray<T: Serializable>(_ objects: [T],forKey key: String){
        let values = objects.map { (object) -> SerializerEncoder in
            let encoder = SerializerEncoder()
            object.encode(encoder)
            return encoder
        }.map({$0.properties})
        properties.updateValue(values as AnyObject, forKey: key)
    }
    
    
    open func encodeDoubleArray(_ doubleArray: [Double], forKey key: String){
        properties[key] = doubleArray as AnyObject?
    }
    
    open func encodeIntArray(_ intArray: [Int], forKey key: String){
        return properties[key] = intArray as AnyObject?
    }
    
    open func encodeStringArray(_ stringArray: [String], forKey key: String){
        return properties[key] = stringArray as AnyObject?
    }
    
    open func encodeObject<K,T>(_ object: T ,forKey key: String, withDataTransformer transformer: DataTransformer<T,K>){
        properties.updateValue(transformer.toJSON(object) as AnyObject, forKey: key)        
    }
}
