//
//  APINameService.swift
//  Example
//
//  Created by Damian Esteban on 06/11/2016.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation
import Moya
import Result

/// Conforms to the `NetworkServiceType` protocol
class ColorsService: NetworkServiceType {
    
    // MARK: - Provider
    var provider: MoyaProvider<APIName>
    
    // Default implementation of the initializer.  We do this because while running the app the Service
    // will always be initialized this way, but for testing we can provide a different MoyaProvider
    required init(provider: MoyaProvider<APIName> = MoyaProvider<APIName>(plugins:
        [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])) {
        self.provider = provider
    }
    
    /*  This method makes use of the `requestObjects` method from the protocol extension.
        Because all of the objects we are making requests for conform to `JSONDeserializable`
        and because we always pass in a `TargetType` our methods can always be nice and short like
        this.
    */
    func getColors(target: APIName, completion: @escaping (Result<[ColorModel], DomainError>) -> Void) {
        return self.requestObjects(target: target, completion: completion)
    }
    
    // This method makes use of the `requestObject` method from the protocol extension.
    func getColor(target: APIName, completion: @escaping (Result<ColorModel, DomainError>) -> Void) {
        self.requestObject(target: target, completion: completion)
    }
}

