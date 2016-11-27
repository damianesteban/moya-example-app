//
//  CredentialsType.swift
//  Example
//
//  Created by Damian Esteban on 10/11/2016.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation
import Result

// Credential and CredentialsServiceType
protocol CredentialType {
    var key: String { get }
    var value: String { get }
}

protocol CredentialsServiceType {
    func saveCredential(credential: CredentialType) -> Bool
}
