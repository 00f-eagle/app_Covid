//
//  SummaryModel.swift
//  Covid
//
//  Created by Kirill Selivanov on 23.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

struct SummaryModel: Decodable {
    var global: GlobalModel
    let date: String
    let countries: [CountryModel]
    
    var convertedDate : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: dateStringToDate)
    }
    
    private var dateStringToDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.date(from: date)!
    }
    
    enum CodingKeys: String, CodingKey {
        case global = "Global"
        case date = "Date"
        case countries = "Countries"
    }
}
