//
//  DayModel.swift
//  Covid
//
//  Created by Kirill Selivanov on 23.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

struct DayModel: Decodable {
    
    let confirmed: Int
    let deaths: Int
    let recovered: Int
    let date: String
    
    var convertedDate : String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let dateStringToDate = formatter.date(from: date) else { return "22.01.20" }
        formatter.dateFormat = "dd.MM.yy"
        return formatter.string(from: dateStringToDate)
    }
    
    var convertedDateToDate: Date {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "UTC")
        formatter.dateFormat = "dd.MM.yy"
        return formatter.date(from: convertedDate)!
    }
    
    enum CodingKeys: String, CodingKey {
        case confirmed = "Confirmed"
        case deaths = "Deaths"
        case recovered = "Recovered"
        case date = "Date"
    }
}
