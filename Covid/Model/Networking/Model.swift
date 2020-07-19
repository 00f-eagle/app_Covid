//
//  Model.swift
//  Covid
//
//  Created by Kirill Selivanov on 08.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

import UIKit

// MARK: - GlobalModel

struct GlobalModel: Decodable {
    let global: Global
    let date: String
    let countries: [Countries]
    
    enum CodingKeys: String, CodingKey {
        case global = "Global"
        case date = "Date"
        case countries = "Countries"
    }
}

// MARK: - CountriesModel

struct CountriesModel: Decodable {
    let countries: [Countries]
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case countries = "Countries"
        case date = "Date"
    }
}

// MARK: - SummaryModel

struct SummaryModel: Decodable {
    
    let countries: [Countries]
    let global: Global
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case global = "Global"
        case date = "Date"
        case countries = "Countries"
    }

}

// MARK: - DayOneModel

struct DayOneModel: Decodable {
    
    let country: String
    let countryCode: String
    let province: String
    let city: String
    let cityCode: String
    let lat: String
    let lon: String
    let confirmed: Int
    let deaths: Int
    let recovered: Int
    let active: Int
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case countryCode = "CountryCode"
        case province = "Province"
        case city = "City"
        case cityCode = "CityCode"
        case lat = "Lat"
        case lon = "Lon"
        case confirmed = "Confirmed"
        case deaths = "Deaths"
        case recovered = "Recovered"
        case active = "Active"
        case date = "Date"
    }
}

// MARK: - Global

struct Global: Decodable {
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

// MARK: - Countries

struct Countries: Decodable {
    let country: String
    let countryCode: String
    let slug: String
    let newConfirmed: Int
    let totalConfirmed: Int
    let newDeaths: Int
    let totalDeaths: Int
    let newRecovered: Int
    let totalRecovered: Int
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case country = "Country"
        case countryCode = "CountryCode"
        case slug = "Slug"
        case newConfirmed = "NewConfirmed"
        case totalConfirmed = "TotalConfirmed"
        case newDeaths = "NewDeaths"
        case totalDeaths = "TotalDeaths"
        case newRecovered = "NewRecovered"
        case totalRecovered = "TotalRecovered"
        case date = "Date"
    }
}
