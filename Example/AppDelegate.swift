//
//  AppDelegate.swift
//  Example
//
//  Created by Damian Esteban on 05/11/2016.
//  Copyright © 2016 betterPT. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        installRootViewController(into: window)
        configureWindow()
        configureNavigationBarStyle()
        window?.makeKeyAndVisible()
        return true
    }
    
    // TODO: Add appcoordinator / appcontroller
    // Installs the root viewcontroller into the UIWindow
    private func installRootViewController(into window: UIWindow?) {
        let viewController = ServiceLocator.provideRootViewControllerWithService()
        window?.rootViewController = viewController
    }
    
    // Configures the UIWindow
    private func configureWindow() {
        window?.backgroundColor = UIColor.windowBackgroundColor
    }
    
    // Configures the app-wide navbar appearance
    private func configureNavigationBarStyle() {
        let navigationBarAppearance = UINavigationBar.appearance()
        navigationBarAppearance.barTintColor = UIColor.navigationBarColor
        navigationBarAppearance.tintColor = UIColor.navigationBarTitleColor
        navigationBarAppearance.isTranslucent = false
        navigationBarAppearance.titleTextAttributes = [
            NSForegroundColorAttributeName : UIColor.navigationBarTitleColor
        ]
    }
}

