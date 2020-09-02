//
//  CovidFacade.swift
//  Covid
//
//  Created by Kirill Selivanov on 26.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

protocol CovidFacadeProtocol {
    func getMainStatisticsByCountry(countryCode: String, completionHandler: @escaping (StatisticsModel?) -> Void)
    func getAllDaysByCountry(countryCode: String, completionHandler: @escaping ([DayModel]?) -> Void)
    func getMainStatisticsByGlobal(completionHandler: @escaping (StatisticsModel?) -> Void)
}

final class CovidFacade: CovidFacadeProtocol {
    
    private let covidNetworking: NetworkServiceProtocol
    private let statisticsData: StatisticsStorageProtocol
    
    init(covidNetworking: NetworkServiceProtocol, statisticsData: StatisticsStorageProtocol) {
        self.covidNetworking = covidNetworking
        self.statisticsData = statisticsData
    }
    
    func getMainStatisticsByCountry(countryCode: String, completionHandler: @escaping (StatisticsModel?) -> Void) {
        covidNetworking.getSummary { [weak self] (model) in
            DispatchQueue.main.async {
                
                guard let self = self else {
                    completionHandler(nil)
                    return
                }
                
                if let model = model {
                    self.statisticsData.addCountries(countries: model.countries)
                }
                
                if let countryStatistics = self.statisticsData.getCountry(countryCode: countryCode) {
                    completionHandler(countryStatistics)
                } else {
                    completionHandler(nil)
                }
            }
        }
    }
    
    func getAllDaysByCountry(countryCode: String, completionHandler: @escaping ([DayModel]?) -> Void) {
        covidNetworking.getAllDays(countryCode: countryCode) { [weak self] (model) in
            DispatchQueue.main.async {
                guard let self = self else {
                    completionHandler(nil)
                    return
                }
                
                guard let model = model else {
                    if let allDays = self.statisticsData.getLastDays(countryCode: countryCode) {
                        completionHandler(allDays)
                    } else {
                        completionHandler(nil)
                    }
                    return
                }
                completionHandler(model)
                self.statisticsData.addLastDays(countryCode: countryCode, data: model)
            }
        }
    }
    
    func getMainStatisticsByGlobal(completionHandler: @escaping (StatisticsModel?) -> Void) {
        covidNetworking.getSummary { [weak self] (model) in
            DispatchQueue.main.async {
                guard let self = self else {
                    completionHandler(nil)
                    return
                }
                
                if let model = model {
                    self.statisticsData.addGlobal(data: model.global, date: model.convertedDate)
                }
                
                if let globalStatistics = self.statisticsData.getGlobal() {
                    completionHandler(globalStatistics)
                } else {
                    completionHandler(nil)
                }
            }
        }
    }
}
