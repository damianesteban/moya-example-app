//
//  CredentialsService.swift
//  Example
//
//  Created by Damian Esteban on 10/11/2016.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation
import KeychainAccess
import Result

/// KeychainService - Manages keychain item
struct KeychainService: CredentialsServiceType {
    
    // MARK: Properties
    private let keychain = Keychain(service: Constants.KeychainService)
    
    // MARK: Methods
    /// Saves a credential to the keychain
    func saveCredential(credential: CredentialType) -> Bool {
        do {
            try keychain.set(credential.value, key: credential.key)
            return true
        } catch let error {
            print("Error: \(DomainError(message: error.localizedDescription))")
            return false
        }
    }
    
    // TODO: Add update and delete methods
}
