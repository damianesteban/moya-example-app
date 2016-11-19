//
//  DatabaseService.swift
//  Example
//
//  Created by Damian Esteban on 11/18/16.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation
import RealmSwift
import Result

class DatabaseService: DataSourceType {
   typealias Object = RealmColorModel
    
    let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func fetchAllObjects() -> Result<[RealmColorModel], DomainError> {
        let results = realm.objects(RealmColorModel.self)
        let objectsArray = results.toArray(ofType: RealmColorModel.self)
        return Result.success(objectsArray)
    }
    
    func fetchObjectById(objectId: String) -> Result<RealmColorModel, DomainError> {
        let predicate = NSPredicate(format: "id = %@", objectId)
        let object = realm.objects(RealmColorModel.self).filter(predicate)
        guard let queriedObject = object.first else {
            return Result.failure(DomainError(message: "Error: unable to fetch object from Realm"))
        }
        return Result.success(queriedObject)
    }
    
    func insertOrUpdateObject(object: RealmColorModel) -> Result<Void, DomainError> {
        do {
            try realm.write {
                realm.add(object, update: true)
            }
            return Result.success()
        } catch let error {
            return Result.failure(DomainError(message: error.localizedDescription))
        }
    }
    
    func deleteObjectByID(object: RealmColorModel) -> Result<Void, DomainError> {
        do {
            try realm.write {
                realm.delete(object)
            }
            return Result.success()
        } catch let error {
            return Result.failure(DomainError(message: error.localizedDescription))
        }
    }
    
    func clearAll() -> Result<Void, DomainError> {
        do {
            try realm.write {
                realm.deleteAll()
            }
            return Result.success()
        } catch let error {
            return Result.failure(DomainError(message: error.localizedDescription))
        }
    }
}
