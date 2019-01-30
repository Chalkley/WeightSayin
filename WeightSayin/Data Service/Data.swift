//
//  Data.swift
//  WeightSayin
//
//  Created by Jason Chalkley on 11/06/2018.
//  Copyright © 2018 Jason Chalkley. All rights reserved.
//

import Foundation

class DataService {
    
    static let instance = DataService()
    
    private let settings = [
    Settings(title: "About", image: "aboutGrey"),
    Settings(title: "Send feedback", image: "emailGrey"),
    Settings(title: "Rate", image: "rateGrey"),
    Settings(title: "Share", image: "shareGrey"),
    Settings(title: "Website", image: "internetGrey")
    
    ]
    
    func getSettings() -> [Settings] {
        return settings
    }
    
    private let social = [
    SocialMedia(image: "instagram"),
    SocialMedia(image: "appstore"),
    SocialMedia(image: "linkedin"),
    SocialMedia(image: "internet")
    ]
    
    func getSocial() -> [SocialMedia] {
        return social 
    }
    
}




