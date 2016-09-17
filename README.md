# JSONSerializer

![](https://img.shields.io/badge/Language-Swift-orange.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) 

Convenience API based on NSCoding architeture to retrive JSON from webserices and transform then into objects.

# Instalation

## Carthage 

After configure [Carthage](https://github.com/Carthage/Carthage) into your project. See the link if you made the configs yet.

In your cartfile put this dependency

```
  github "LucianoPAlmeida/JSONSerializer" ~> 1.0

```

## Usage 

Import the module Serializer

````

import Serializer

```


Implement your model acording the **Serializable** Protocol 

````
  
  class Object: NSObject, Serializable {
    
    var str: String!
    var integer: Int!
    var embbed: Embbed!
    var numbers: [Int]!
    var strings: [String]!
    var doubles: [Double]!
    var arrayEmbbeds: [Embbed]!
    var date: NSDate!
    
    
    required init(decoder: SerializerDecoder) {
        str = decoder.decodeString("str")
        integer = decoder.decodeInteger("int")
        embbed = decoder.decodeSerializableObject("embbed")
        numbers = decoder.decodeIntArray("intarray")
        strings = decoder.decodeStringArray("strings")
        doubles = decoder.decodeDoubleArray("doubles")
        arrayEmbbeds = decoder.decodeSerializableObjectArray("embbedArray")
        date = decoder.decodeObject(key: "date", withDataTransformer: DefaultDateTransformer())
    }
    
    func encode(enconder: SerializerEncoder) {
        enconder.encodeString(str, forKey: "str")
        enconder.encodeInteger(integer, forKey: "int")
        enconder.encodeSerializableObject(embbed, forKey: "embbed")
        enconder.encodeIntArray(numbers, forKey: "intarray")
        enconder.encodeStringArray(strings, forKey: "strings")
        enconder.encodeDoubleArray(doubles, forKey: "doubles")
        enconder.encodeSerializableObjectArray(arrayEmbbeds, forKey: "embbedArray")
        enconder.encodeObject(date, forKey: "date", withDataTransformer: DefaultDateTransformer())
    }
}

class Embbed: NSObject , Serializable{
    var str: String!
    var number: Int!
    
    required init(decoder: SerializerDecoder) {
        str = decoder.decodeString("str")
        number = decoder.decodeInteger("number")
    }
    
    func encode(enconder: SerializerEncoder) {
        enconder.encodeString(str, forKey: "str")
        enconder.encodeInteger(number, forKey: "number")
    }
    
    override var description: String{
        return "Embbed = [str = \(str), number = \(number)]"
    }
}

```

After implement your model acording the protocol, your can retrive json from a server and call a deserializer to transform it into objects.

````
let data : NSData = ...//Data from server 
Deserializer<Object>.objects(data)

```
or an already value/key dictionary 

````

let dict : [String : AnyObject] = ...// Value/key json parser
Deserializer<Object>.objects(dict)

```
