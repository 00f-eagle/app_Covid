//
//  GlobalEntity+CoreDataProperties.swift
//  Covid
//
//  Created by Kirill Selivanov on 27.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//
//

import Foundation
import CoreData


extension GlobalEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GlobalEntity> {
        return NSFetchRequest<GlobalEntity>(entityName: "GlobalEntity")
    }

    @NSManaged public var code: String
    @NSManaged public var date: String
    @NSManaged public var name: String
    @NSManaged public var newConfirmed: Int64
    @NSManaged public var newDeaths: Int64
    @NSManaged public var newRecovered: Int64
    @NSManaged public var totalConfirmed: Int64
    @NSManaged public var totalDeaths: Int64
    @NSManaged public var totalRecovered: Int64

}
