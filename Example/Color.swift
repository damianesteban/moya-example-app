//
//  Color.swift
//  Example
//
//  Created by Damian Esteban on 06/11/2016.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation
import RealmSwift

// A Color - this is in the Domain
class ColorModel: Object, JSONDeserializable {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var year = 0
    dynamic var pantoneValue = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience required init(jsonRepresentation: JSONDictionary) throws {
        self.init()
        id = try decode(jsonRepresentation, key: "id")
        name = try decode(jsonRepresentation, key: "name")
        year = try decode(jsonRepresentation, key: "year")
        pantoneValue = try decode(jsonRepresentation, key: "pantone_value")
    }
}
