//
//  ListViewModelType.swift
//  Example
//
//  Created by Damian Esteban on 11/21/16.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation
import RealmSwift

protocol ListViewModelType {
    associatedtype ListObject
    var numberOfItems: Int { get }
    func item(at index: Int) -> ListObject
}

class ColorsListViewModel: ListViewModelType {
    var realm: Realm

    typealias ListObject = RealmColorModel

    var results: Results<RealmColorModel>
    
    var numberOfItems: Int {
        return results.count
    }
    
    init(realm: Realm) {
        self.realm = realm
        let color = RealmColorModel(name: "Red", year: 1997, pantoneValue: "pantoneeeeee")
        let realm = try! Realm()
        try! realm.write {
            realm.add(color)
        }
        results = realm.objects(RealmColorModel.self)

    }
    
    func item(at index: Int) -> RealmColorModel {
        return results[index]
    }
}

