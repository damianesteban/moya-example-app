//
//  RealmRepositoryType.swift
//  Example
//
//  Created by Damian Esteban on 11/20/16.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation
import RealmSwift


protocol RealmRepositoryType {
    var realm: Realm { get set }
    init(realm: Realm)
    func fetchAllObjects<T: Object>(type: T.Type) -> Results<T>?
    func fetchObjectById<T: Object>(id: String, type: T.Type) -> Results<T>?
    func insertOrUpdateObject(object: Object)
    func deleteObjectById(id: String)
    func clearAllObjects()
}

extension RealmRepositoryType {
    
    func fetchAllObjects<T: Object>(type: T.Type) -> Results<T>? {
        let results = realm.objects(type)
        return results
    }
    
    func fetchObjectById<T: Object>(id: String, type: T.Type) -> Results<T>? {
        let predicate = NSPredicate(format: "id = %@", id)
        let results = realm.objects(type).filter(predicate)
        return results
    }
    
    func insertOrUpdateObject(object: Object) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch let error {
            print(error)
        }
    }
    
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
