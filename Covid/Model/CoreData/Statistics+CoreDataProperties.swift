//
//  Statistics+CoreDataProperties.swift
//  Covid
//
//  Created by Kirill Selivanov on 23.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//
//

import Foundation
import CoreData


extension Statistics {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Statistics> {
        return NSFetchRequest<Statistics>(entityName: "Statistics")
    }

    @NSManaged public var confirmed: Int64
    @NSManaged public var country: String
    @NSManaged public var deaths: Int64
    @NSManaged public var incConfirmed: Int64
    @NSManaged public var incDeaths: Int64
    @NSManaged public var incRecoverded: Int64
    @NSManaged public var recovered: Int64

}
