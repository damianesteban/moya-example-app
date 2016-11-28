//
//  UIState+Delegate.swift
//  Example
//
//  Created by Damian Esteban on 11/27/16.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation

enum UIState {
    case loading
    case success
    case failure(Error)
}

protocol UIStateDelegate: class {
    var state: UIState { get set }
}

//class AnyUIStateDelegate<T>: UIStateDelegate {
//    var state: UIState<T> {
//        get { return _getNewState() }
//        set { _setNewState(newValue) }
//    }
//    
//    private let _getNewState: () -> UIState<T>
//    private let _setNewState: (UIState<T>) -> Void
//    
//    required init<U: UIStateDelegate>(_ models: U) where U.Model == T {
//        _getNewState = { models.state }
//        _setNewState = { models.state = $0 }
//    }
//}
