//
//  DataTransformer.swift
//  Serializer
//
//  Created by Luciano Almeida on 9/3/16.
//  Copyright © 2016 Luciano Almeida. All rights reserved.
//

import Foundation

open class DataTransformer<K,T> {
    func toJSON(_ object: K)-> T {
        fatalError("\(#function) is an abstract Method")
    }
    func fromJSON(_ object: T) -> K {
        fatalError("\(#function) is an abstract Method")
    }
}
