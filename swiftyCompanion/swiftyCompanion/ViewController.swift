//
//  ViewController.swift
//  swiftyCompanion
//
//  Created by Marc FAMILARI on 10/16/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAccessToken.getAccessToken()
    }
}

