//
//  ServiceLocator.swift
//  Example
//
//  Created by Damian Esteban on 08/11/2016.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation
import UIKit

/// ServiceLocator.  Read more about this design pattern here: https://msdn.microsoft.com/en-us/library/ff648968.aspx
class ServiceLocator {
    static let sharedInstance = ServiceLocator()
    
    // Convenience function for Storyboard
    private static var storyBoard: UIStoryboard = {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }()
    
    // Convenience function for rootviewcontroller
    private static func provideUIViewControllerWithName(name: String) -> UIViewController {
        return storyBoard.instantiateViewController(withIdentifier: name)
    }
    
    // Returns a ColorsService
    private static func provideAPINameServiceService() -> ColorsService {
        let colorsService = ColorsService()
        return colorsService
    }
    
    // Returns a UserService
    private static func provideUserService() -> UserService {
        let userService = UserService()
        return userService
    }
    
    // Returns a KeychainService 
    private static func provideKeychainService() -> KeychainService {
        let keychainService = KeychainService()
        return keychainService
    }
    
    // Returns the UserSignupViewController (the rootViewController) with its dependencies.
    static func provideRootViewControllerWithViewModel() -> UserSignupViewController {
        let ivs = UserSignupInputValidationService()
        let networkService = UserService()
        let ups = NewUserProvisioningService(networkService: networkService, keychainService: provideKeychainService())
        let viewModel = UserSignupViewModel(inputValidationService: ivs, userProvisioningService: ups)
        let viewController = provideUIViewControllerWithName(name: "UserSignupViewController") as! UserSignupViewController
        viewController.viewModel = viewModel
        return viewController
    }
    
    // Services

}
