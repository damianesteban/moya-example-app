//
//  ServiceLocator.swift
//  Example
//
//  Created by Damian Esteban on 08/11/2016.
//  Copyright © 2016 betterPT. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

// ServiceLocator.
// Read more about this design pattern here: https://msdn.microsoft.com/en-us/library/ff648968.aspx
class ServiceLocator {
    
    // Singleton
    static let sharedInstance = ServiceLocator()
    
    // Convenience function for Storyboard
    private static var storyBoard: UIStoryboard = {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }()
    
    // Convenience function for rootviewcontroller
    private static func provideUIViewControllerWithName(name: String) -> UIViewController {
        return storyBoard.instantiateViewController(withIdentifier: name)
    }
    
    // Provides an instance of the ColorsService
    private static func provideColorsService() -> ColorsService {
        let colorsService = ColorsService()
        return colorsService
    }
    
    // Provides an instance of the UserService
    private static func provideUserService() -> UserService {
        let userService = UserService()
        return userService
    }
    
    // Provides an instance of the KeychainService
    private static func provideKeychainService() -> KeychainService {
        let keychainService = KeychainService()
        return keychainService
    }
    
    // Provides an instances of the UserSignupInputValidationService
    private static func provideInputValidationService() -> UserSignupInputValidationService {
        let userSignupInputValidationService = UserSignupInputValidationService()
        return userSignupInputValidationService
    }
    
    // Provides and instance of the NewUserProvisioningService
    private static func provideNewUserProvisioningService() -> NewUserProvisioningService {
        let userService = provideUserService()
        let keychainService = provideKeychainService()
        let newUserProvisioningService = NewUserProvisioningService(networkService: userService,
            keychainService: keychainService)
        return newUserProvisioningService
    }
    
    // Provides an instance of the DataStore
    private static func provideColorsDataStore() -> ColorsDataStore {
        let realm = try! Realm()
        let colorsDataStore = ColorsDataStore(realm: realm)
        return colorsDataStore
    }
    
    // Provides an instance of ColorsListViewModel
    private static func providesColorsViewModel() -> ColorsListViewModel {
        let networkingService = provideColorsService()
        let dataStore = provideColorsDataStore()
        let viewModel = ColorsListViewModel(dataStore: dataStore, networkService: networkingService)
        return viewModel
    }
    
    
    // Returns the UserSignupViewController (the rootViewController) with its dependencies
    static func provideRootViewControllerWithViewModel() -> UserSignupViewController {
        let userProvisioningService = provideNewUserProvisioningService()
        let newUserInputValidationService = provideInputValidationService()
        let viewModel = UserSignupViewModel(inputValidationService: newUserInputValidationService,
            userProvisioningService: userProvisioningService)
        let viewController = provideUIViewControllerWithName(name: "UserSignupViewController") as! UserSignupViewController
        viewController.viewModel = viewModel
        return viewController
    }
    
    // Returns the ColorsViewController with its dependencies (for this example it is set as the rootViewController)
    static func provideListViewControllerWithViewModel() -> UIViewController {
        let viewController = provideUIViewControllerWithName(name: "ColorsViewController") as! ColorsViewController
        viewController.viewModel = providesColorsViewModel()
        let navController = UINavigationController(rootViewController: viewController)
        return navController
    }
}
