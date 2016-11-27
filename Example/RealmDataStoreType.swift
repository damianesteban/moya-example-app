//
//  RealmRepositoryType.swift
//  Example
//
//  Created by Damian Esteban on 11/20/16.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation
import RealmSwift

// A Repository for Realm Objects
protocol RealmDataStoreType {
    var realm: Realm { get set }
    func fetchAllObjects<T: Object>(type: T.Type) -> Results<T>?
    func fetchObjectById<T: Object>(id: String, type: T.Type) -> Results<T>?
    func insertOrUpdateObject(object: Object)
    func deleteObjectById(id: String)
    func clearAllObjects()
}

extension RealmDataStoreType {
    
    // Fetches Realm Results of the provided Object Type
    func fetchAllObjects<T: Object>(type: T.Type) -> Results<T>? {
        let results = realm.objects(type)
        return results
    }
    
    // Fetches Realm Resultsby id of the provided Object Type
    func fetchObjectById<T: Object>(id: String, type: T.Type) -> Results<T>? {
        let predicate = NSPredicate(format: "id = %@", id)
        let results = realm.objects(type).filter(predicate)
        return results
    }
    
    // Inserts or updates a Realm Object
    func insertOrUpdateObject(object: Object) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch let error {
            print(error)
        }
    }
    
    // Deletes a Realm Object by id
    func deleteObjectById<T: Object>(id: String, type: T.Type) {
        let results = fetchObjectById(id: id, type: type)
        if let results = results?.first {
            do {
                try realm.write {
                    realm.delete(results)
                }
            } catch let error {
                print(error)
            }
        }
    }
    
    // Clears all objects from the Realm
    func clearAllObjects() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch let error {
            print(error)
        }
    }
}
