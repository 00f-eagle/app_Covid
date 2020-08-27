//
//  StatisticsFacade.swift
//  Covid
//
//  Created by Kirill Selivanov on 26.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

protocol StatisticsFacadeProtocol {
    func getMainStatisticsByCountry(countryCode: String, completionHandler: @escaping (StatisticsModel?) -> Void)
    func getAllDaysByCountry(countryCode: String, completionHandler: @escaping ([AllDaysModel]?) -> Void)
}

final class CovidFacade: StatisticsFacadeProtocol {
    
    private let covidNetworking: NetworkServiceProtocol
    private let statisticsData: StatisticsStorageProtocol
    
    init(loadCovidNetworking: NetworkServiceProtocol, statisticsData: StatisticsStorageProtocol) {
        self.covidNetworking = loadCovidNetworking
        self.statisticsData = statisticsData
    }
    
    func getMainStatisticsByCountry(countryCode: String, completionHandler: @escaping (StatisticsModel?) -> Void) {
        covidNetworking.getSummary { [weak self] (model) in
            DispatchQueue.main.async {
                if let model = model { self?.statisticsData.addCountries(countries: model.countries) }
                let countryStatistics = self?.statisticsData.getCountry(countryCode: countryCode)
                completionHandler(countryStatistics)
            }
        }
    }
    
    func getAllDaysByCountry(countryCode: String, completionHandler: @escaping ([AllDaysModel]?) -> Void) {
        covidNetworking.getAllDays(countryCode: countryCode) { [weak self] (model) in
            DispatchQueue.main.async {
                if let model = model { self?.statisticsData.addLastDays(countryCode: countryCode, data: model) }
                let allDays = self?.statisticsData.getLastDays(countryCode: countryCode)
                completionHandler(allDays)
            }
        }
    }
}
