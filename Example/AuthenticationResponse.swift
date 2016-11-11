//
//  AuthenticationResponse.swift
//  Example
//
//  Created by Damian Esteban on 10/11/2016.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation

/// AuthenticationResponse
/**
 Is this model necessary?  Probably not...at least not for this app.  But consider an
 app where you have many endopints and the responses are structured in a similar way.
 In that case you may want to create a `ResponseObject`.
**/
struct AuthenticationResponse {
    let token: String
}

extension AuthenticationResponse: JSONDeserializable {
    init(jsonRepresentation: JSONDictionary) throws {
        token = try decode(jsonRepresentation, key: "token")
    }
}
