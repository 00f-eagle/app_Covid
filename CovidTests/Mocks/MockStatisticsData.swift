//
//  MockStatisticsData.swift
//  CovidTests
//
//  Created by Kirill Selivanov on 03.09.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit
@testable import Covid

final class MockStatisticsData: StatisticsStorageProtocol {

    var isCalledAddCountries = false
    var isCalledAddGlobal = false
    var isCalledAddLastDays = false
    var isCalledGetCountries = false
    var isCalledGetGlobal = false
    var isCalledGetCountry = false
    var isCalledGetLastDays = false
    
    var countries: [StatisticsModel]?
    
    func addCountries(countries: [CountryModel]) {
        isCalledAddCountries = true
    }
    
    func getCountry(countryCode: String) -> StatisticsModel? {
        isCalledGetCountry = true
        return nil
    }
    
    func getCountries(searchText: String) -> [StatisticsModel]? {
        isCalledGetCountries = true
        return countries
    }
    
    func addGlobal(data: GlobalModel, date: String) {
        isCalledAddGlobal = true
    }
    
    func getGlobal() -> StatisticsModel? {
        isCalledGetGlobal = true
        return nil
    }
    
    func addLastDays(countryCode: String, data: [DayModel]) {
        isCalledAddLastDays = true
    }
    
    func getLastDays(countryCode: String) -> [DayModel]? {
        isCalledGetLastDays = true
        return nil
    }
}
