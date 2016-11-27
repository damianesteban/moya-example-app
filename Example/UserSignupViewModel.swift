//
//  UserSignupViewModel.swift
//  Example
//
//  Created by Damian Esteban on 11/18/16.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation

class UserSignupViewModel: UserSignupViewModelType {
    
    // MARK: - Properties
    var passwordPlaceholderText = "username"
    var usernamePlaceholderText = "password"
    
    // When this is true, the user is able to tap the signupButton
    var submitButtonEnabled: Bool {
        return usernameValid && passwordValid
    }
    
    // MARK: - Private
    
    // Service classes
    private let inputValidationService: UserSignupInputValidationService
    private let userProvisioningService: NewUserProvisioningService
    
    // Properties
    private var usernameText: String = ""
    private var passwordText: String = ""
    private var usernameValid = false
    private var passwordValid = false
    
    // MARK: Delegate
    weak var delegate: UserSignupViewModelDelegate?
    
    // MARK: - Initializer
    init(inputValidationService: UserSignupInputValidationService,
         userProvisioningService: NewUserProvisioningService) {
        self.inputValidationService = inputValidationService
        self.userProvisioningService = userProvisioningService

    }
    
    // Validates the contents of the username and password textFields and either makes a network request
    // or forwards a message to the delegate to display an error in a UIAlertController.
    func signupButtonPressed() {
        print("tapped")
        do {
            try inputValidationService.validateUsername(usernameText)
            try inputValidationService.validatePassword(passwordText)
            print("all good")
            submitUserSignupInformation()
        } catch {
            self.delegate?.showError()
        }
    }
    
    // Makes the network request via the service class and either displays an error or moves to the next view.
    private func submitUserSignupInformation() {
        userProvisioningService.provisionNewUser(with: usernameText, password: passwordText) { (success, error) in
            if error != nil {
                self.delegate?.showError()
            }
            if success == true {
                print("yay!")
                self.delegate?.nextView()
            }
        }
    }
    
    // MARK: - Delegate methods for textFields
    func usernameTextDidChange(text: String?) {
        usernameText = text ?? ""
        do {
            try inputValidationService.validateUsername(usernameText)
            usernameValid = true
        } catch {
            usernameValid = false
        }
    }
    
    func passwordTextDidChange(text: String?) {
        passwordText = text ?? ""
        do {
            try inputValidationService.validatePassword(passwordText)
            usernameValid = true
        } catch {
            usernameValid = false
        }
    }
}
