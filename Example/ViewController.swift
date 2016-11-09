//
//  ViewController.swift
//  Example
//
//  Created by Damian Esteban on 05/11/2016.
//  Copyright © 2016 betterPT. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var service: APINameService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service?.getColors(target: APIName.colors) { result in
            switch result {
            case let .success(colors):
                print(colors)
            case let .failure(error):
                print(error)
            }
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

