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
struct APINameService: NetworkServiceType {
    
    // MARK: - Provider
    var provider: MoyaProvider<APIName>
    
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

