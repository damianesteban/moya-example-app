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
    
    // This method makes use of the `requestObject` method from the protocol extension.
    func registerUser(target: APIName, completion: @escaping (Result<UserAuthenticationToken, DomainError>) -> Void) {
        return self.requestObject(target: target, completion: completion)
    }
}
