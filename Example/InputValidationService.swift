//
//  InputValidationService.swift
//  Example
//
//  Created by Damian Esteban on 11/19/16.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation

protocol InputValidationServiceType {
    func validateUsername(_ username: String?) throws
    func validatePassword(_ password: String?) throws
}

// Basic input validation service.
class UserSignupInputValidationService: InputValidationServiceType {
    func validateUsername(_ username: String?) throws {
        guard let username = username, !username.isEmpty else {
            throw DomainError(message: "Invalid input for username")
        }
    }
    
    func validatePassword(_ password: String?) throws {
        guard let password = password, !password.isEmpty else {
            throw DomainError(message: "Invalid input for password")
        }
    }
}

