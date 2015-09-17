//
//  ViewController.swift
//  Random
//
//  Created by Rahul Sundararaman on 7/23/15.
//  Copyright (c) 2015 Rahul Sundararaman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
         let diceRoll = Int(arc4random_uniform(2))
        NSLog(String(diceRoll));
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

