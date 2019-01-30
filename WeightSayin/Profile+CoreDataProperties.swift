//
//  Profile+CoreDataProperties.swift
//  WeightSayin
//
//  Created by Jason Chalkley on 13/06/2018.
//  Copyright © 2018 Jason Chalkley. All rights reserved.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var name: String?
    @NSManaged public var weight: Double
    @NSManaged public var goalWeight: Double

}
