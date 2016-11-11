//
//  UserService.swift
//  Example
//
//  Created by Damian Esteban on 10/11/2016.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation
import Moya
import Result

/// Conforms to the `NetworkServiceType` protocol
struct UserService: NetworkServiceType {
    
    // MARK: - Provider
    var provider: MoyaProvider<APIName>

    // Default implementation of the initializer.  We do this because while running the app the Service
    // will always be initialized this way, but for testing we can provide a different MoyaProvider
    init(provider: MoyaProvider<APIName> = MoyaProvider<APIName>(plugins:
        [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])) {
        self.provider = provider
    }
    
    // This method makes use of the `requestObject` method from the protocol extension.
    func registerUser(target: APIName, completion: @escaping (Result<UserAuthenticationToken, DomainError>) -> Void) {
        return self.requestObject(target: target, completion: completion)
    }
}
