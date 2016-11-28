//
//  Functions.swift
//  Example
//
//  Created by Damian Esteban on 06/11/2016.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation
import Result
import Moya

// NOTE: Normally I would *not* force cast like this.
func objectToDictionary(object: Any) -> JSONDictionary {
    let dictionary = object as! JSONDictionary
    return dictionary
}

func parseObjectToDictionary(object: Any) -> Result<JSONDictionary, DomainError> {
    guard let dictionary = object as? JSONDictionary else {
        return Result.failure(DomainError(message: "Unable to parse object to dictionary"))
    }
    
    return Result.success(dictionary)
}

func parseDictionaryToJSONArray(dictionary: JSONDictionary) -> Result<[JSONDictionary], DomainError> {
    guard let array = dictionary["data"] as? [JSONDictionary] else {
        return Result.failure(DomainError(message: "Unable to parse dictionary to json array"))
    }
    
    return Result.success(array)
}

func parseArrayToObjects<T>(array: [JSONDictionary]) -> Result<[T], DomainError> where T: JSONDeserializable {
    print(array)
    do {
        let objects: [T] = try array.flatMap { try T(jsonRepresentation: $0) }
        return Result.success(objects)
    } catch let error {
        return Result.failure(DomainError(message: error.localizedDescription))
    }
}

// GCD Convenience Function
func delay(seconds: Int, completion: @escaping (Void) -> (Void)) {
    let time = DispatchTime.now() + .seconds(seconds)
    DispatchQueue.main.asyncAfter(deadline: time) {
        print("delay")
        completion()
    }
}
