//
//  SummaryModel.swift
//  Covid
//
//  Created by Kirill Selivanov on 23.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

// MARK: - SummaryModel
struct SummaryModel: Decodable {
    let global: GlobalModel
    let date: String
    let countries: [CountryModel]
    
    enum CodingKeys: String, CodingKey {
        case global = "Global"
        case date = "Date"
        case countries = "Countries"
    }
}

// MARK: - GlobalModel
struct GlobalModel: Decodable {
    let newConfirmed: Int
    let totalConfirmed: Int
    let newDeaths: Int
    let totalDeaths: Int
    let newRecovered: Int
    let totalRecovered: Int
    
    enum CodingKeys: String, CodingKey {
        case newConfirmed = "NewConfirmed"
        case totalConfirmed = "TotalConfirmed"
        case newDeaths = "NewDeaths"
        case totalDeaths = "TotalDeaths"
        case newRecovered = "NewRecovered"
        case totalRecovered = "TotalRecovered"
    }
}
