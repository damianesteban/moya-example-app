//
//  ColorsViewModel.swift
//  Example
//
//  Created by Damian Esteban on 11/21/16.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation
import RealmSwift
import Result

// DataStore
class ColorsDataStore: RealmDataStoreType {
    var realm: Realm
    init(realm: Realm) {
        self.realm = realm
    }
}

// ListViewModel - In this case, the ViewModel fetches and updates the datsource via sercice classes.
class ColorsListViewModel: ListViewModelType {
    
    // MARK: - Properties
    typealias ListObject = ColorModel
    var results: Results<ColorModel>
    var dataStore: ColorsDataStore
    var networkService: ColorsService
    
    var didUpdateState: ((_ state: UIState) -> Void)?
    var delegate: UIStateDelegate?
    
    var numberOfItems: Int {
        return results.count
    }
    
    // MARK: Initializer
    init(dataStore: ColorsDataStore, networkService: ColorsService) {
        self.networkService = networkService
        self.dataStore = dataStore
        results = dataStore.realm.objects(ColorModel.self)
    }
    
    // MARK: Delegate method
    func item(at index: Int) -> ColorModel {
        return results[index]
    }
    
    // Fetches the objects from the server and updates the Realm.  This can be
    // refactored to be a bit cleaner.
    func fetchAndUpdateColors(completion: @escaping (_ state: UIState) -> Void) {
        networkService.getColors(target: .colors) { [weak self] result in
            do {
                let colors = try result.dematerialize()
                if !colors.isEmpty {
                    completion(.success)
                }
                self?.dataStore.insertOrUpdateObjects(objects: colors)
                if let newResults = self?.dataStore.fetchAllObjects(type: ColorModel.self) {
                    self?.results = newResults
                    completion(.success)
                }
            } catch let error {
                completion(.failure(error))
            }
        }
    }
}
