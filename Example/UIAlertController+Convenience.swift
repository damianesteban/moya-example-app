//
//  UIAlertController+Convenience.swift
//  Example
//
//  Created by Damian Esteban on 11/19/16.
//  Copyright © 2016 betterPT. All rights reserved.
//


import UIKit

extension UIAlertController {
    
    /**
     A `UIAlertController` made to show an alert or error message that's passed in.
     
     - parameter title: The title of the alert.
     - parameter body: The body of the alert.
     
     - returns:  A `UIAlertController` with an 'Okay' button.
     */
    convenience init(title: String, body: String) {
        self.init(title: title, message: body, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: NSLocalizedString("Okay", comment: "Okay"), style: .default) { action in
            self.dismiss(animated: true, completion: nil)
        }
        self.addAction(okayAction)
    }
    
    /**
     A `UIAlertController` made to execute UIAction(s) that are passed in.
     
     - parameter title: The title of the alert.
     - parameter body: The body of the alert.
     - parameter actions: The UIAlertActions(s)
     
     - returns:  A `UIAlertController` with UIAlertAction(s)
     */
    convenience init(title: String, body: String, actions: [UIAlertAction]) {
        self.init(title: title, message: body, preferredStyle: .alert)
        actions.forEach { action in
            self.addAction(action)
        }
    }
}
