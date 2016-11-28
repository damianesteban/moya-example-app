//
//  ListViewModelType.swift
//  Example
//
//  Created by Damian Esteban on 11/21/16.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation
import RealmSwift

// ListViewModel
protocol ListViewModelType {
    associatedtype ListObject
    var numberOfItems: Int { get }
    func item(at index: Int) -> ListObject
}
