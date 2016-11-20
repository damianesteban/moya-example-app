//
//  Bindable.swift
//  Example
//
//  Created by Damian Esteban on 11/19/16.
//  Copyright © 2016 betterPT. All rights reserved.
//

import UIKit

// This class is used for simple value bindings.
class Bindable<T> {
    typealias Listener = (T) -> Void
    
    var listener: Listener?
    
    func bind(listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(value: T) {
        self.value = value
    }
}
