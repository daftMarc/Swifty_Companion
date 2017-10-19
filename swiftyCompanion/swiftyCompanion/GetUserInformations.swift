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
        
        self.getUserID(login)
    }
    
    
    func getUserID(_ login: String) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let parameters: Parameters = ["filter[login]": login]
        guard let bearer = UserDefaults.standard.value(forKey: Constants.accessToken) as? String else {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            _ = GetAccessToken(delegate: SearchViewController(), login: login)
            return
        }
        let headers = ["Authorization": "Bearer \(bearer)"]
        let users = "v2/users"
        
        Alamofire.request(Constants.api + users, parameters: parameters, headers: headers).responseJSON { response in
            if let code = response.response?.statusCode, code != 200 {
                print("CODE = \(code)")
                switch code {
                case 401:
                    // Token is expired
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    UserDefaults.standard.set(nil, forKey: Constants.accessToken)
                    _ = GetAccessToken(delegate: SearchViewController(), login: login)
                    return
                default:
                    self.delegate?.displayServerError()
                }
            }
            if let result = response.result.value {
                let json = JSON(result)
                if let id = json[0]["id"].int { self.getUserInformations(login, id) }
                else { self.delegate?.displayNoResultError(login: login) }
            }
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    func getUserInformations(_ login: String, _ id: Int) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        guard let bearer = UserDefaults.standard.value(forKey: Constants.accessToken) as? String else {
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            _ = GetAccessToken(delegate: SearchViewController(), login: login)
            return
        }
        let headers = ["Authorization": "Bearer \(bearer)"]
        let users = "v2/users/\(id)"
        
        Alamofire.request(Constants.api + users, headers: headers).responseJSON { response in
            if let result = response.result.value {
                let json = JSON(result)
                self.parseUserJSON(json)
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
    
    func parseUserJSON(_ json: JSON) {
        var user = User()
        
        if let firstName = json["first_name"].string { user.firstName = firstName }
        if let lastName = json["last_name"].string { user.lastName = lastName }
        if let lastName = json["cursus_users"]["user"]["login"].string { user.lastName = lastName }
        if let login = json["login"].string { user.login = login }
        if let phone = json["phone"].string { user.phone = phone }
        if let wallet = json["wallet"].int { user.wallet = wallet }
        if let correctionPoint = json["correction_point"].int { user.correctionPoint = correctionPoint }
        if let level = json["cursus_users"][0]["level"].double { user.level = level }
        if let image = json["image_url"].string { user.image = image }
        
        user.projects = [(String, Int)]()
        if let projects = json["projects_users"].array {
            for element in projects {
                if let status = element["status"].string, status == "finished" {
                    if let name = element["project"]["name"].string, let finalMark = element["final_mark"].int {
                        user.projects?.append((name, finalMark))
                    }
                }
            }
        }
        
        user.skills = [(String, Double)]()
        if let cursusUsers = json["cursus_users"].array {
            for cursus in cursusUsers {
                if let skills = cursus["skills"].array {
                    for skill in skills {
                        if let name = skill["name"].string, let level = skill["level"].double { user.skills?.append((name, level)) }
                    }
                }
            }
        }
        
        print(user)
    }
    
}
