//
//  SerializerDecoder.swift
//  Serializer
//
//  Created by Luciano Almeida on 9/3/16.
//  Copyright © 2016 Luciano Almeida. All rights reserved.
//

import UIKit

public class SerializerDecoder: NSObject {

    private(set) var properties: [String: AnyObject]
    
    init(properties: [String : AnyObject]) {
        self.properties = properties
    }
    
    
    public func decodeInteger(key: String)-> Int {
        return properties[key] as? Int ?? 0
    }
    
    public func decodeDouble(key: String) -> Double {
        return properties[key] as? Double ?? 0
    }
    
    public func decodeNumber(key: String) -> NSNumber{
        return properties[key] as? NSNumber ?? 0
    }
    
    public func decodeString(key: String) -> String {
        return properties[key] as? String ?? ""
    }
    
    
    public func decodeSerializableObject<T: Serializable>(key: String)-> T? {
        if let obj = properties[key] as? [String : AnyObject] {
           return T.init(decoder: SerializerDecoder(properties: obj))
        }
        return nil
    }
    
    
    public func decodeSerializableObjectArray<T: Serializable>(key: String)-> [T]? {
        if let objects = properties[key] as? [[String : AnyObject]]{
            return objects.map({return T.init(decoder: SerializerDecoder(properties: $0))})
        }
        return nil
    }
        
    
    public func decodeDoubleArray(key: String)-> [Double]?{
        return properties[key] as? [Double]
    }
    
    public func decodeIntArray(key: String)-> [Int]? {
        return properties[key] as? [Int]
    }
    
    public func decodeStringArray(key: String) -> [String]? {
        return properties[key] as? [String]
    }
    
    public func decodeObject<K,T>(key key: String, withDataTransformer transformer: DataTransformer<T,K>)-> T?{
        if let value = properties[key] as? K {
            return transformer.fromJSON(value)
        }
        return nil
    }
}
