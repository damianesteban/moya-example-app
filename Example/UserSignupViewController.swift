//
//  UserSignupViewController.swift
//  Example
//
//  Created by Damian Esteban on 10/11/2016.
//  Copyright © 2016 betterPT. All rights reserved.
//

import UIKit

class UserSignupViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var signupButton: UIButton!
    
    // MARK: - Properties
    var userService: UserService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signupButton.backgroundColor = UIColor(named: .Indigo)
        // Do any additional setup after loading the view.
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
