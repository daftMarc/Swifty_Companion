//
//  GetAccessToken.swift
//  swiftyCompanion
//
//  Created by Marc FAMILARI on 10/17/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GetAccessToken {
    
    
    var delegate: SearchViewController!
    var login: String?
    
    
    init(delegate: SearchViewController, login: String?) {
        self.delegate = delegate
        self.login = login
        
        self.getAccessToken()
    }
    
    
    func getAccessToken() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let parameters: Parameters = ["grant_type": "client_credentials",
                                      "client_id": Constants.UID,
                                      "client_secret": Constants.secret
        ]
        let oauth = "oauth/token/"
        
        Alamofire.request(Constants.api + oauth, method: .post, parameters: parameters).responseJSON { response in
            if let result = response.result.value {
                let json = JSON(result)
                if let accessToken = json["access_token"].string {
                    UserDefaults.standard.set(accessToken, forKey: Constants.accessToken)
                    if self.login != nil { _ = GetUserInformations(delegate: self.delegate, login: self.login!) }
                }
            }
            if let code = response.response?.statusCode, code != 200 {
                self.delegate?.displayServerError()
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
}
