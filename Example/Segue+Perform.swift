//
//  Segue+Perform.swift
//  Example
//
//  Created by Damian Esteban on 11/20/16.
//  Copyright © 2016 betterPT. All rights reserved.
//

import UIKit

// Convenience extension for Segues
extension UIViewController {
    func performSegue<T:RawRepresentable>(identifier: T, sender: AnyObject?) where T.RawValue == String {
        self.performSegue(withIdentifier: identifier.rawValue, sender: sender)
    }
}
