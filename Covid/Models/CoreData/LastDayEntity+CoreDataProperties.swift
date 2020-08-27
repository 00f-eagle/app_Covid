//
//  LastDayEntity+CoreDataProperties.swift
//  Covid
//
//  Created by Kirill Selivanov on 26.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//
//

import Foundation
import CoreData


extension LastDayEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LastDayEntity> {
        return NSFetchRequest<LastDayEntity>(entityName: "LastDayEntity")
    }

    @NSManaged public var confirmed: Int64
    @NSManaged public var date: String
    @NSManaged public var deaths: Int64
    @NSManaged public var recovered: Int64
    @NSManaged public var code: String

}
