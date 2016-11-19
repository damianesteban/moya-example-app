//
//  RealmInitializable.swift
//  Example
//
//  Created by Damian Esteban on 11/18/16.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation
import RealmSwift

/// Convenience protocol to provide a common initializer for Realm Objects
protocol RealmInitializable {
    associatedtype RealmObject
    init?(object: RealmObject)
}
