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
    var skills: [[String: Any]]?
    var projects: [[String: Any]]?
    
    var description: String {
        return ("first name = \(self.firstName)\nlast name = \(self.lastName)\nlogin = \(self.login)\nphone = \(self.phone)\nwallet = \(self.wallet)\ncorrection point = \(self.correctionPoint)\nlevel = \(self.level)\nimage = \(self.image)")
    }
    
}
