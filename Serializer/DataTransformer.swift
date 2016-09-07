//
//  DataTransformer.swift
//  Serializer
//
//  Created by Luciano Almeida on 9/3/16.
//  Copyright © 2016 Luciano Almeida. All rights reserved.
//

import Foundation

public class DataTransformer<K,T> {
    func toJSON(object: K)-> T {
        fatalError("Abstract Method")
    }
    func fromJSON(object: T) -> K {
        fatalError("Abstract Method")
    }
}