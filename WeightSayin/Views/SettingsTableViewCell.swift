//
//  SettingsTableViewCell.swift
//  WeightSayin
//
//  Created by Jason Chalkley on 19/06/2018.
//  Copyright © 2018 Jason Chalkley. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var settingsLbl: UILabel!
    
    @IBOutlet weak var settingsImg: UIImageView!
    
    func updateViews(settings: Settings) {
        settingsLbl.text = settings.title
        settingsImg.image = UIImage(named: settings.image!)
        
        }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        settingsLbl.textColor = #colorLiteral(red: 0.3333333333, green: 0.3333333333, blue: 0.3333333333, alpha: 1)
        settingsLbl.font = UIFont(name: "Avenir Next", size: 18)
        settingsLbl.font = UIFont.boldSystemFont(ofSize: 18)
        
        settingsImg.clipsToBounds = true 
    }
}
