//
//  Settings.swift
//  WeightSayin
//
//  Created by Jason Chalkley on 11/06/2018.
//  Copyright © 2018 Jason Chalkley. All rights reserved.
//

import Foundation

struct Settings {
    
    var title: String
    var image: String?
    
    init(title: String, image: String) {
        self.title = title
        self.image = image
    }
    
}
