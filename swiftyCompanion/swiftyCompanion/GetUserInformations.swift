//
//  GetUserInformations.swift
//  swiftyCompanion
//
//  Created by Marc FAMILARI on 10/17/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class GetUserInformations {
    
    
    var delegate: SearchViewController?
    
    
    init(delegate: SearchViewController, login: String) {
        self.delegate = delegate
        
        self.getUserID(login: login)
    }
    
    
    func getUserID(login: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let parameters: Parameters = ["filter[login]": login]
        guard let bearer = UserDefaults.standard.value(forKey: Constants.accessToken) as? String else {
            _ = GetAccessToken(delegate: SearchViewController(), login: login)
            return
        }
        let headers = ["Authorization": "Bearer \(bearer)"]
        let users = "v2/users"
        
        Alamofire.request(Constants.api + users, parameters: parameters, headers: headers).responseJSON { response in
            if let result = response.result.value {
                let json = JSON(result)
                if let id = json[0]["id"].int { self.getUserInformations(id: id) }
                else { self.delegate?.displayNoResultError(login: login) }
            }
            if let code = response.response?.statusCode, code != 200 {
                print("CODE = \(code)")
                switch code {
                case 401:
                    // Token is expired
                    UserDefaults.standard.set(nil, forKey: Constants.accessToken)
                    _ = GetAccessToken(delegate: SearchViewController(), login: login)
                default:
                    self.delegate?.displayServerError()
                }
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    func getUserInformations(id: Int) {
        print("YOLO")
    }

}
