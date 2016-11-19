//
//  UserSignupViewModel.swift
//  Example
//
//  Created by Damian Esteban on 11/18/16.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation

class UserSignupViewModel {
    
    // Input
    let usernameString = ""
    let passwordString = ""
    
    // Output
    
    // Private
    private var userService: UserService
    private var keychainService: KeychainService
    
    init(userService: UserService, keychainService: KeychainService) {
        self.userService = userService
        self.keychainService = keychainService
    }
    
    
}
