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

struct KeychainService: CredentialsServiceType {
    private let keychain = Keychain(service: Constants.KeychainService)
    
    func saveCredential(credential: CredentialType) -> Result<Void, DomainError> {
        do {
            try keychain.set(credential.value, key: credential.key)
            return Result.success()
        } catch let error {
            return Result.failure(DomainError(message: error.localizedDescription))
        }
    }
}
