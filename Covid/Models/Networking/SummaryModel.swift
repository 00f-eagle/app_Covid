//
//  SummaryModel.swift
//  Covid
//
//  Created by Kirill Selivanov on 23.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

struct SummaryModel: Decodable {
    let global: GlobalModel
    let date: String
    let countries: [CountryModel]
    
    var convertedDate : String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let dateStringToDate = formatter.date(from: date) else { return "22.01.2020" }
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: dateStringToDate)
    }
    
    enum CodingKeys: String, CodingKey {
        case global = "Global"
        case date = "Date"
        case countries = "Countries"
    }
}
