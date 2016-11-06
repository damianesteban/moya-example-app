//
//  NetworkService.swift
//  Example
//
//  Created by Damian Esteban on 05/11/2016.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation
import Result
import Moya

/// NetworkServiceType: Provides basic methods for Networking Services with Moya
protocol NetworkServiceType {
    // add moyaprovider init
    var provider: MoyaProvider<APIName> { get set }
    func requestJSON(target: APIName, completion: @escaping (Result<JSONDictionary, DomainError>) -> Void)
    func requestObject<T: JSONDeserializable>(target: APIName, completion: @escaping (Result<T, DomainError>) -> Void)
    func requestObjects<T: JSONDeserializable>(target: APIName, completion: @escaping (Result<[T], DomainError>) -> Void)
}

extension NetworkServiceType {
    
    func requestJSON(target: APIName, completion: @escaping (Result<JSONDictionary, DomainError>) -> Void) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let json = try response.mapJSON()
                    let jsonParsingResult = parseObjectToDictionary(object: json)
                    completion(jsonParsingResult)
                } catch let error {
                    completion(Result.failure(error as! DomainError))
                }
            case .failure(_):
                print("error!!!")
                completion(Result.failure(DomainError(message: "unable to request json")))
            }
        }
    }
    
    func requestObject<T: JSONDeserializable>(target: APIName, completion: @escaping (Result<T, DomainError>) -> Void) {
        self.requestJSON(target: target) { result in
            switch result {
            case let .success(json):
                do {
                    let object = try T(jsonRepresentation: json)
                    completion(Result.success(object))
                } catch let error {
                    completion(Result.failure(error as! DomainError))
                }
            case .failure(_):
                completion(Result.failure(DomainError(message: "Unable to request object")))
            }
        }
    }
    
    func requestObjects<T: JSONDeserializable>(target: APIName, completion: @escaping (Result<[T], DomainError>) -> Void) {
        self.requestJSON(target: target) { result in
            switch result {
            case let .success(json):
                    let result = parseDictionaryToJSONArray(dictionary: json)
                    switch result {
                    case let .success(json):
                        let objectArrayResult: Result<[T], DomainError> = parseArrayToObjects(array: json)
                        completion(objectArrayResult)
                    case .failure(_):
                        completion(Result.failure(DomainError(message: "Unable to request objects")))
                    }
            case .failure(_):
                completion(Result.failure(DomainError(message: "Unable to request objects")))
            }
        }
    }
}
