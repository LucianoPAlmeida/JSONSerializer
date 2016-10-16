//
//  DefaultDateTransformer.swift
//  Serializer
//
//  Created by Luciano Almeida on 9/7/16.
//  Copyright © 2016 Luciano Almeida. All rights reserved.
//

import Foundation

open class DefaultDateTransformer: DataTransformer<Date,String?>{
    fileprivate var dateFormatter: DateFormatter!
    
    var dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSS z" /*ISO Format*/{
        didSet{
            dateFormatter?.dateFormat = dateFormat
        }
    }
    
    public override init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
    }
    
    convenience init(dateFormat: String) {
        self.init()
        self.dateFormat = dateFormat
    }
    
    override func toJSON(_ object: Date) -> String?{
        return dateFormatter.string(from: object)
    }
    
    override func fromJSON(_ object: String?) -> Date {
        if let string = object {
            return dateFormatter.date(from: string) ?? Date()
        }
        return  Date()
    }
}
