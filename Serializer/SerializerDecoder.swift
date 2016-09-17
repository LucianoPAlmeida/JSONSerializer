//
//  SerializerDecoder.swift
//  Serializer
//
//  Created by Luciano Almeida on 9/3/16.
//  Copyright © 2016 Luciano Almeida. All rights reserved.
//

import UIKit

open class SerializerDecoder: NSObject {

    fileprivate(set) var properties: [String: AnyObject]
    
    init(properties: [String : AnyObject]) {
        self.properties = properties
    }
    
    
    open func decodeInteger(_ key: String)-> Int {
        return properties[key] as? Int ?? 0
    }
    
    open func decodeDouble(_ key: String) -> Double {
        return properties[key] as? Double ?? 0
    }
    
    open func decodeNumber(_ key: String) -> NSNumber{
        return properties[key] as? NSNumber ?? 0
    }
    
    open func decodeString(_ key: String) -> String {
        return properties[key] as? String ?? ""
    }
    
    
    open func decodeSerializableObject<T: Serializable>(_ key: String)-> T? {
        if let obj = properties[key] as? [String : AnyObject] {
           return T.init(decoder: SerializerDecoder(properties: obj))
        }
        return nil
    }
    
    
    open func decodeSerializableObjectArray<T: Serializable>(_ key: String)-> [T]? {
        if let objects = properties[key] as? [[String : AnyObject]]{
            return objects.map({return T.init(decoder: SerializerDecoder(properties: $0))})
        }
        return nil
    }
        
    
    open func decodeDoubleArray(_ key: String)-> [Double]?{
        return properties[key] as? [Double]
    }
    
    open func decodeIntArray(_ key: String)-> [Int]? {
        return properties[key] as? [Int]
    }
    
    open func decodeStringArray(_ key: String) -> [String]? {
        return properties[key] as? [String]
    }
    
    open func decodeObject<K,T>(key: String, withDataTransformer transformer: DataTransformer<T,K>)-> T?{
        if let value = properties[key] as? K {
            return transformer.fromJSON(value)
        }
        return nil
    }
}
