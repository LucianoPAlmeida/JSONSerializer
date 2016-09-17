//
//  DefaultDateTransformer.swift
//  Serializer
//
//  Created by Luciano Almeida on 9/7/16.
//  Copyright © 2016 Luciano Almeida. All rights reserved.
//

import Foundation

open class DefaultDateTransformer: DataTransformer<Date,String?>{
    fileprivate var dateFomatter: DateFormatter!
    
    public override init() {
        dateFomatter = DateFormatter()
        dateFomatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS z" //ISO Format
    }
    
    override func toJSON(_ object: Date) -> String?{
        return dateFomatter.string(from: object)
    }
    
    override func fromJSON(_ object: String?) -> Date {
        if let string = object {
            return dateFomatter.date(from: string) ?? Date()
        }
        return  Date()
    }
}
