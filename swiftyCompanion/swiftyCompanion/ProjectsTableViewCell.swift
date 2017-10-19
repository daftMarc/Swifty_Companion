//
//  ProjectsTableViewCell.swift
//  swiftyCompanion
//
//  Created by Marc FAMILARI on 10/19/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//

import UIKit

class ProjectsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var themeLabel: UILabel!
    
    
    var projects: (String, String, Int)? {
        didSet {
            updateUI()
        }
    }
    
    
    func updateUI() {
        self.nameLabel.text = ""
        self.themeLabel.text = ""
        
        if let project = self.projects {
            self.nameLabel.text = "\(project.0) - \(String(project.2))%"
            self.themeLabel.text = project.1
        }
    }

}
