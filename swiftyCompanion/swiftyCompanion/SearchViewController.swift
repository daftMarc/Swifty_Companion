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
    
    
    @IBAction func searchLoginAction(_ sender: UIButton) {
        self.searchLoginButton.isEnabled = false
        guard var login = self.searchLoginTextField.text, login != "" else {
            self.searchLoginButton.isEnabled = true
            return
        }
        
        login = login.trimmingCharacters(in: .whitespacesAndNewlines)
        if UserDefaults.standard.value(forKey: Constants.accessToken) == nil {
            _ = GetAccessToken.init(delegate: self, login: login)
        } else {
            _ = GetUserInformations(delegate: self, login: login)
        }
    }
    
    
    @IBOutlet weak var searchLoginTextField: UITextField!
    @IBOutlet weak var searchLoginButton: UIButton!
    
    var user: User? {
        didSet {
            self.prepareForScrollView()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.standard.value(forKey: Constants.accessToken) == nil {
            _ = GetAccessToken.init(delegate: self, login: nil)
        }
        
        // Set corner radius for text field and button
        self.searchLoginTextField.layer.cornerRadius = 15
        self.searchLoginButton.layer.cornerRadius = 15
    }
    
    
    
    
    // MARK: - HandleAccesToken delegate
    
    func displayServerError() {
        self.searchLoginButton.isEnabled = true
        let alertController = UIAlertController(title: "Error", message: "Can't get 'access token' from server", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func displayNoResultError(login: String) {
        self.searchLoginButton.isEnabled = true
        let alertController = UIAlertController(title: "Error", message: "No result for login : '\(login)'", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    // MARK: - NAVIGATION
    
    func prepareForScrollView() {
        self.searchLoginButton.isEnabled = true
        let destinationvc = storyboard?.instantiateViewController(withIdentifier: "User Informations") as! UserInformationsViewController
        
        destinationvc.user = self.user
        
        self.navigationController?.pushViewController(destinationvc, animated: true)
    }
}
