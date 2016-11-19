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

class RealmService {
    let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func fetchAllObjectsOfType(_ type: Object.Type) -> Result<[Object], DomainError> {
        let results = realm.objects(type)
        let array = results.toArray(ofType: type)
        return Result.success(array)
    }
    
    func fetchObjectById(objectId: String, type: Object.Type) -> Result<Object, DomainError> {
        let predicate = NSPredicate(format: "id = %@", objectId)
        let object = realm.objects(type).filter(predicate)
        guard let queriedObject = object.first else {
            return Result.failure(DomainError(message: "Error: unable to fetch object from Realm"))
        }
        return Result.success(queriedObject)
    }
    
    func insertOrUpdateObject(object: Object) -> Bool {
        do {
            try realm.write {
                realm.add(object, update: true)
            }
            return true
        } catch let error {
            print("Error: \(DomainError(message: error.localizedDescription))")
            return false
        }
    }
    
    func deleteObject(object: Object) -> Bool {
        do {
            try realm.write {
                realm.delete(object)
            }
            return true
        } catch let error {
            print("Error: \(DomainError(message: error.localizedDescription))")
            return false
        }
    }
    
    func clearAll() -> Bool {
        do {
            try realm.write {
                realm.deleteAll()
            }
            return true
        } catch let error {
            print("Error: \(DomainError(message: error.localizedDescription))")
            return false
        }
    }

}
