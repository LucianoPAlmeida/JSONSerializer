//
//  SerializerEncoder.swift
//  Serializer
//
//  Created by Luciano Almeida on 9/3/16.
//  Copyright © 2016 Luciano Almeida. All rights reserved.
//

import Foundation

open class SerializerEncoder: NSObject {
    fileprivate(set) var properties: [String: Any] = [:]
    
    
    
    open func encodeInteger(_ intValue: Int, forKey key: String){
        properties[key] = intValue
    }
    
    open func encodeDouble(_ doubleValue: Double, forKey key: String){
        properties[key] = doubleValue
    }
    
    open func encodeLong(_ number: NSNumber, forKey key: String){
        properties[key] = number
    }
    
    open func encodeString(_ string: String, forKey key: String) {
        properties[key] = string
    }
    
    open func encodeDictionary(_ dictionary: String, forKey key: String){
        return properties[key] = dictionary
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
        properties.updateValue(values , forKey: key)
    }
    
    
    open func encodeDoubleArray(_ doubleArray: [Double], forKey key: String){
        properties[key] = doubleArray
    }
    
    open func encodeIntArray(_ intArray: [Int], forKey key: String){
        properties[key] = intArray
    }
    
    open func encodeStringArray(_ stringArray: [String], forKey key: String){
        properties[key] = stringArray
    }
    
    open func encodeObject<K,T>(_ object: T ,forKey key: String, withDataTransformer transformer: DataTransformer<T,K>){
        properties.updateValue(transformer.toJSON(object), forKey: key)        
    }
}
