//
//  Color.swift
//  Example
//
//  Created by Damian Esteban on 06/11/2016.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation

/// A Color
struct ColorModel {
    let id: Int
    let name: String
    let year: Int
    let pantoneValue: String
}

// Conforms to JSONODeserializable
extension ColorModel: JSONDeserializable {
    init(jsonRepresentation: JSONDictionary) throws {
        id = try decode(jsonRepresentation, key: "id")
        name = try decode(jsonRepresentation, key: "name")
        year = try decode(jsonRepresentation, key: "year")
        pantoneValue = try decode(jsonRepresentation, key: "pantone_value")
    }
}
