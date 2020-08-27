//
//  CountryModel.swift
//  Covid
//
//  Created by Kirill Selivanov on 27.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

struct CountryModel: Decodable {
    let name: String
    let code: String
    let newConfirmed: Int
    let totalConfirmed: Int
    let newDeaths: Int
    let totalDeaths: Int
    let newRecovered: Int
    let totalRecovered: Int
    let date: String
    
    var convertedDate : String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let dateStringToDate = formatter.date(from: date) else { return "22.01.2020" }
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: dateStringToDate)
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "Country"
        case code = "CountryCode"
        case newConfirmed = "NewConfirmed"
        case totalConfirmed = "TotalConfirmed"
        case newDeaths = "NewDeaths"
        case totalDeaths = "TotalDeaths"
        case newRecovered = "NewRecovered"
        case totalRecovered = "TotalRecovered"
        case date = "Date"
    }
}
