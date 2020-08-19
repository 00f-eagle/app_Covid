//
//  User+CoreDataProperties.swift
//  Covid
//
//  Created by Kirill Selivanov on 04.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var countryCode: String

}
