//
//  SettingsCollectionViewCell.swift
//  WeightSayin
//
//  Created by Jason Chalkley on 19/06/2018.
//  Copyright © 2018 Jason Chalkley. All rights reserved.
//

import UIKit

class SettingsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var socialImage: UIImageView!
    
    func updateViews(socialMedia: SocialMedia) {
        socialImage.image = UIImage(named: socialMedia.image!)
    }
}
