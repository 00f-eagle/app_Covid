//
//  Country+CoreDataProperties.swift
//  Covid
//
//  Created by Kirill Selivanov on 18.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var totalConfirmed: Int64
    @NSManaged public var country: String
    @NSManaged public var date: String
    @NSManaged public var totalDeaths: Int64
    @NSManaged public var newConfirmed: Int64
    @NSManaged public var newDeaths: Int64
    @NSManaged public var newRecovered: Int64
    @NSManaged public var totalRecovered: Int64
    @NSManaged public var countryCode: String

}
