//
//  RealmUser.swift
//  Example
//
//  Created by Damian Esteban on 11/18/16.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation
import RealmSwift

class RealmUserModel: Object {
    dynamic var id = UUID.init().uuidString.lowercased()
    dynamic var username = ""
    dynamic var password = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}