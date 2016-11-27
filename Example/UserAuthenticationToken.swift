//
//  UserAuthenticationToken.swift
//  Example
//
//  Created by Damian Esteban on 10/11/2016.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation

// UserAuthenticationToken
struct UserAuthenticationToken: CredentialType {
    let key = Constants.UserTokenKey
    let value: String
}

extension UserAuthenticationToken: JSONDeserializable {
    init(jsonRepresentation: JSONDictionary) throws {
        value = try decode(jsonRepresentation, key: "token")
    }
}
