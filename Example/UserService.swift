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
class UserService: NetworkServiceType {

    // MARK: - Properties
    var provider: MoyaProvider<APIName>
    
    // MARK: - Initializer(s)
    // Default implementation of the initializer.  We do this because while running the app the Service
    // will always be initialized this way, but for testing we can provide a different MoyaProvider
    required init(provider: MoyaProvider<APIName> = MoyaProvider<APIName>(plugins:
        [NetworkLoggerPlugin(verbose: true, responseDataFormatter: JSONResponseDataFormatter)])) {
        self.provider = provider
    }
    
    // MARK: - Methods
    // This method makes use of the `requestObject` method from the protocol extension.
    func registerUser(email: String, password: String,
                      completion: @escaping (Result<UserAuthenticationToken, DomainError>) -> Void) {
        return self.requestObject(target: .register(email: email, password: password), completion: completion)
    }
    
}
