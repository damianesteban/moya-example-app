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
    
    // Returns a `APINameService`
    private static func provideAPINameServiceService() -> APINameService {
        let apiNameService = APINameService()
        return apiNameService
    }
    
    static func provideRootViewControllerWithService() -> ViewController {
        let service = provideAPINameServiceService()
        let viewController = provideUIViewControllerWithName(name: "ViewController") as! ViewController
        viewController.service = service
        return viewController
    }
}
