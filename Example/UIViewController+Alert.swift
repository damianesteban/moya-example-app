//
//  UIViewController+Alert.swift
//  Example
//
//  Created by Damian Esteban on 11/19/16.
//  Copyright © 2016 betterPT. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Displays a `UIAlertController` with the passed-in text and an 'Okay' button.
    func displayMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, body: message)
        self.present(alert, animated: true, completion: nil)
    }
    
    /// Displays a `UIAlertController` with the passed-in text, 'Okay' button and UIAlertAction(s)
    func displayAlertWithActions(title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, body: message, actions: actions)
        self.present(alert, animated: true, completion: nil)
    }
    
    /**
     Displays `UIAlertController` with a message and a localized "Error" title.
     
     - parameter message: The message to display.
     */
    private func displayErrorMessage(message: String) {
        let errorTitle = NSLocalizedString("Error", comment: "Error")
        displayMessage(title: errorTitle, message: message)
    }
}
