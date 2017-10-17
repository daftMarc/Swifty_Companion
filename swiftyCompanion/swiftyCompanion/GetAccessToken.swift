//
//  GetAccessToken.swift
//  swiftyCompanion
//
//  Created by Marc FAMILARI on 10/17/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//

import Foundation
import Alamofire

class getAccessToken {
    
    static func getAccessToken() {
        let parameters: Parameters = ["grant_type": "client_credentials",
                                      "client_id": Constants.UID,
                                      "client_secret": Constants.secret
        ]
        let oauth = "oauth/token/"
        
        
        Alamofire.request(Constants.api + oauth, method: .post, parameters: parameters).responseJSON { response in
            if let result = response.result.value {
                let json = result as! NSDictionary
                if let accessToken = json["access_token"] as? String {
                    UserDefaults.standard.set(accessToken, forKey: Constants.accessToken)
                }
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
    }
    
    
}
