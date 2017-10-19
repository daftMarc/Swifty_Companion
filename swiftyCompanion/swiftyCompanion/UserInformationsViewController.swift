//
//  UserInformationsViewController.swift
//  swiftyCompanion
//
//  Created by Marc FAMILARI on 10/19/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//

import UIKit
import SDWebImage

class UserInformationsViewController: UIViewController {
    
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var walletLabel: UILabel!
    @IBOutlet weak var correctionPointLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    var user: User!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set UI
        if let firstName = self.user.firstName, let lastName = self.user.lastName { self.nameLabel.text = "\(firstName)  \(lastName.uppercased())" }
        if let login = self.user.login { self.loginLabel.text = login }
        if let phone = self.user.phone { self.phoneNumberLabel.text = phone }
        if let wallet = self.user.wallet { self.walletLabel.text = "Wallet : \(String(wallet))" }
        if let correction = self.user.correctionPoint { self.correctionPointLabel.text = "Correction \(String(correction))" }
        if let lvl = self.user.level {
            self.levelLabel.text = "Level : \(String(lvl).replacingOccurrences(of: ".", with: " - "))%"
            self.progressView.progress = Float(lvl.truncatingRemainder(dividingBy: 1))
        }
        if let url = self.user.image {
            self.userImage.sd_setImage(with: URL(string: url), placeholderImage: #imageLiteral(resourceName: "placeholder"))
            self.userImage.layer.borderWidth = 3
            self.userImage.layer.borderColor = UIColor.white.cgColor
            self.userImage.layer.cornerRadius = self.userImage.frame.height / 2.0
            self.userImage.layer.masksToBounds = true
        }
    }
    
}
