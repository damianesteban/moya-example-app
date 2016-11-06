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
    do {
        let objects: [T] = try array.flatMap { try T(jsonRepresentation: $0) }
        return Result.success(objects)
    } catch _ {
        return Result.failure(DomainError(message: "Unable to parse array to objects"))
    }
}
