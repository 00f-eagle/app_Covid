//
//  DayOneModel.swift
//  Covid
//
//  Created by Kirill Selivanov on 23.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

struct DayOneModel: Decodable {
    
    let country: String
    let confirmed: Int
    let deaths: Int
    let recovered: Int
    let active: Int
    let date: String
    
    var dateToDate: Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter.date(from: date)!
    }
    
    var convertedDate : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter.string(from: dateToDate)
    }
    
    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case confirmed = "Confirmed"
        case deaths = "Deaths"
        case recovered = "Recovered"
        case active = "Active"
        case date = "Date"
    }
}
