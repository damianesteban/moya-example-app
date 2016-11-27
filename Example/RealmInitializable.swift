//
//  RealmInitializable.swift
//  Example
//
//  Created by Damian Esteban on 11/20/16.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation
import RealmSwift

// Convenience initializer for Domain Objects
protocol RealmInitializable {
    associatedtype Object
    init?(object: Object)
}
