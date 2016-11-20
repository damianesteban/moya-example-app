//
//  UserSignupViewModel+Delegate.swift
//  Example
//
//  Created by Damian Esteban on 11/19/16.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation

protocol UserSignupViewModelType {
    weak var delegate: UserSignupViewModelDelegate? { get set }
    var usernamePlaceholderText: String { get set }
    var passwordPlaceholderText: String { get set }
    func signupButtonPressed()
    func usernameTextDidChange(text: String?)
    func passwordTextDidChange(text: String?)
}

protocol UserSignupViewModelDelegate: class {
    func showError()
    func nextView()
}
