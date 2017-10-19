//
//  SkillsTableViewCell.swift
//  swiftyCompanion
//
//  Created by Marc FAMILARI on 10/19/17.
//  Copyright © 2017 Marc FAMILARI. All rights reserved.
//

import UIKit

class SkillsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    
    var skills: (String, Double)? {
        didSet {
            updateUI()
        }
    }
    
    
    func updateUI() {
        self.nameLabel.text = ""
        self.progressView.progress = 0
        
        if let skill = self.skills {
            self.nameLabel.text = "\(skills?.0 ?? "can't get data") - level \(String(skill.1))"
            self.progressView.progress = Float(skill.1.truncatingRemainder(dividingBy: 1))
        }
    }

}
