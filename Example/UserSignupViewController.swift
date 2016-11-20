//
//  UserSignupViewController.swift
//  Example
//
//  Created by Damian Esteban on 10/11/2016.
//  Copyright © 2016 betterPT. All rights reserved.
//

import UIKit

// Selector convenience extension.
private extension Selector {
    static let signupButtonTapped = #selector(UserSignupViewController.signupButtonTapped)
}

class UserSignupViewController: UIViewController, UITextFieldDelegate, UserSignupViewModelDelegate {

    // MARK: Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    
    // MARK: Properties
    // ViewModel - when the ViewModel is set, its delegate is automatically set.
    var viewModel: UserSignupViewModel? {
        didSet {
            viewModel?.delegate = self
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureAllViews()
    }
    
    // Triggers the signup process in the ViewModel
    func signupButtonTapped(sender: UIButton) {
        viewModel?.signupButtonPressed()
    }
    
    // MARK: - ViewModel delegate methods
    func showError() {
        displayMessage(title: "Invalid Username or Password", message: "Please enter a valid username or password")
    }

    func nextView() {
        // TODO: Implementation Needed
    }
    
    // MARK: - UITextField Delegate method
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        
        if textField == usernameTextField {
            viewModel?.usernameTextDidChange(text: text)
        } else if textField == passwordTextField {
            viewModel?.passwordTextDidChange(text: text)
        }
        return true
    }
}

// MARK: - Convenience extension to set the views' properties
extension UserSignupViewController {
    func configureAllViews() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        usernameTextField.placeholder = viewModel?.usernamePlaceholderText
        passwordTextField.placeholder = viewModel?.passwordPlaceholderText
        signupButton.addTarget(self, action: .signupButtonTapped, for: .touchUpInside)
    }
}
