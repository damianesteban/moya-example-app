//
//  AppStorage.swift
//  Example
//
//  Created by Damian Esteban on 10/11/2016.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation
import KeychainAccess

struct AppStorage {
    private static let keychain = Keychain(service: Constants.KeychainService)
    static let token = keychain[Constants.UserTokenKey]
}
