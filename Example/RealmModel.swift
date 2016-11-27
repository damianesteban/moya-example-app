//
//  RealmModel.swift
//  Example
//
//  Created by Damian Esteban on 11/20/16.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation
import RealmSwift

// A RealmColorModel - Infrastructure Level
class RealmColorModel: Object {
    dynamic var id = UUID.init().uuidString.lowercased()
    dynamic var name = ""
    dynamic var year = 0
    dynamic var pantoneValue = ""
    
    convenience init(name: String, year: Int, pantoneValue: String) {
        self.init()
        self.name = name
        self.year = year
        self.pantoneValue = pantoneValue
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
