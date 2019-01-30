//
//  DateWeightTableViewCell.swift
//  WeightSayin
//
//  Created by Jason Chalkley on 11/06/2018.
//  Copyright © 2018 Jason Chalkley. All rights reserved.
//

import UIKit

class DateWeightTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
