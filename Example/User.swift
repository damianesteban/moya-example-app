//
//  User.swift
//  Example
//
//  Created by Damian Esteban on 08/11/2016.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation

/// A User
struct UserModel {
    let username: String
    let password: String
}

// Conforms to JSONODeserializable
extension UserModel: JSONDeserializable {
    init(jsonRepresentation: JSONDictionary) throws {
        username = try decode(jsonRepresentation, key: "username")
        password = try decode(jsonRepresentation, key: "password")
    }
}

/// Conforms to RealmInitializable
//extension UserModel: RealmInitializable {
//    typealias RealmObject = RealmUserModel
//    init?(object: RealmObject) {
//        self.username = object.username
//        self.password = object.password
//    }
//}
