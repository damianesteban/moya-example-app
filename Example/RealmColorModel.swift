//
//  RealmColorModel.swift
//  Example
//
//  Created by Damian Esteban on 11/18/16.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation
import RealmSwift

class RealmColorModel: Object {
    dynamic var id = UUID.init().uuidString.lowercased()
    dynamic var name = ""
    dynamic var year = 0
    dynamic var pantoneValue = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
