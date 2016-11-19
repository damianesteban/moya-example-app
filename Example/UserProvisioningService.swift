//
//  UserProvisioningService.swift
//  Example
//
//  Created by Damian Esteban on 11/18/16.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation
import Result

/// A provisioning service.
class NewUserProvisioningService {
    
    // MARK: Properties
    var networkService: UserService
    var keychainService: KeychainService
    
    // MARK: Initializer
    init(networkService: UserService, keychainService: KeychainService) {
        self.networkService = networkService
        self.keychainService = keychainService
    }
    
    // MARK: Methods
    
    // NOTE: Example of how to properly document methods
    /**
     Provivisions a new user
     
     - parameters:
        - username: The user's username
        - password: The user's password
        - completion: Indicates the outcome of the operation
        - success: True or False
        - failure: DomainError

   */
    func provisionNewUser(with username: String, password: String,
                          completion: @escaping (_ success: Bool, _ failure: DomainError?) -> Void) {
        
        networkService.registerUser(email: username, password: password) { [unowned self] result in
            switch result {
            case let .success(token):
                let keychainResult = self.keychainService.saveCredential(credential: token)
                keychainResult ? completion(true, nil) : completion(false, DomainError(message: "Error saving item to keychain"))
            case let .failure(error):
                completion(false, DomainError(message: error.localizedDescription))
            }
        }
    }
}
