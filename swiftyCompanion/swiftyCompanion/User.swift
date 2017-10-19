//
//  User.swift
//  swiftyCompanion
//
//  Created by Marc FAMILARI on 10/17/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//

import Foundation

struct User: CustomStringConvertible {
    
    var firstName: String?
    var lastName: String?
    var login: String?
    var phone: String?
    var wallet: Int?
    var correctionPoint: Int?
    var level: Double?
    var image: String?
    var skills: [(String, Double)]?
    var projects: [(String, Int)]?
    
    var description: String {
        return ("first name = \(String(describing: self.firstName))\nlast name = \(String(describing: self.lastName))\nlogin = \(String(describing: self.login))\nphone = \(String(describing: self.phone))\nwallet = \(String(describing: self.wallet))\ncorrection point = \(String(describing: self.correctionPoint))\nlevel = \(String(describing: self.level))\nimage = \(String(describing: self.image))\nprojets = \(String(describing: self.projects)))\nskills = \(String(describing: self.skills))")
    }
    
}
