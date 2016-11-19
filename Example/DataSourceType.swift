//
//  DataSource.swift
//  Example
//
//  Created by Damian Esteban on 11/18/16.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation
import Result

protocol DataSourceType {
    associatedtype Object
    func fetchAllObjects() -> Result<[Object], DomainError>
    func fetchObjectById(objectId: String) -> Result<Object, DomainError>
    func insertOrUpdateObject(object: Object) -> Bool
    func deleteObjectByID(object: Object) -> Bool
    func clearAll() -> Bool
}
