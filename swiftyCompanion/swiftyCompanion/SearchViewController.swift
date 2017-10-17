//
//  SearchViewController.swift
//  swiftyCompanion
//
//  Created by Marc FAMILARI on 10/17/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//

import UIKit

protocol HandleAccesToken {
    func displayServerError()
}

class SearchViewController: UIViewController, HandleAccesToken {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.value(forKey: Constants.accessToken) == nil {
            _ = getAccessToken.init(delegate: self)
        }
    }
    
    
    
    
    // MARK: - HandleAccesToken delegate
    
    func displayServerError() {
        let alertController = UIAlertController(title: "Error", message: "Can't get 'access token' from server", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.cancel))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}
