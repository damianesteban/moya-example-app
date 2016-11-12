//
//  UserSignupViewController.swift
//  Example
//
//  Created by Damian Esteban on 10/11/2016.
//  Copyright © 2016 betterPT. All rights reserved.
//

import UIKit

class UserSignupViewController: UIViewController {

    // MARK: Properties
    // NOTE: Normally I would *never* use implicitly unwrapped optionals in a situation like this,
    // however because TRN Fitness does not use storyboards you can add an initializer to your ViewController.
    var userService: UserService!
    var keychainService: KeychainService!
    
    // MARK:: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // The UserService method makes the network request and the KeychainService saves the token.
        userService.registerUser(email: "bobby@bobby.com", password: "bobby123") { [unowned self] result in
            switch result {
            case let .success(token):
                let tokenResult = self.keychainService.saveCredential(credential: token)
                switch tokenResult {
                case .success(_):
                    print("token saved successfully")
                case let .failure(error):
                    print("error saving token:: \(error)")
                }
            case let .failure(error):
                print("network operation error: \(error)")
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



