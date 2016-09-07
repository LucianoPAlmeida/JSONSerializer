//
//  DefaultDateTransformer.swift
//  Serializer
//
//  Created by Luciano Almeida on 9/7/16.
//  Copyright © 2016 Luciano Almeida. All rights reserved.
//

import Foundation

public class DefaultDateTransformer: DataTransformer<NSDate,String?>{
    private var dateFomatter: NSDateFormatter!
    
    public override init() {
        dateFomatter = NSDateFormatter()
        dateFomatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS z" //ISO Format
    }
    
    override func toJSON(object: NSDate) -> String?{
        return dateFomatter.stringFromDate(object)
    }
    
    override func fromJSON(object: String?) -> NSDate {
        if let string = object {
            return dateFomatter.dateFromString(string) ?? NSDate()
        }
        return  NSDate()
    }
}
