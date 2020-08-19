//
//  StatisticsInteractor.swift
//  Covid
//
//  Created by Kirill Selivanov on 17.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class StatisticsInteractor {
    
    // MARK: Properties
    
    weak var presenter: StatisticsInteractorOutput!
    
    private let loadCovidNetworking: NetworkServiceProtocol
    private let statisticsData: StatisticsDataProtocol
    private let userData: UserDataProtocol
    private let globalData: GlobalDataProtocol
    
    // MARK: - Init
    
    init(loadCovidNetworking: NetworkServiceProtocol, statisticData: StatisticsDataProtocol, userData: UserDataProtocol, globalData: GlobalDataProtocol) {
        self.loadCovidNetworking = loadCovidNetworking
        self.statisticsData = statisticData
        self.userData = userData
        self.globalData = globalData
    }
}


// MARK: - StatisticsInteractorInput
extension StatisticsInteractor: StatisticsInteractorInput {
    
    func loadDataByCountry() {
        loadCovidNetworking.getSummary { [weak self] (response) in
            DispatchQueue.main.async {
                if let model = response {
                    self?.statisticsData.addData(data: model.countries)
                }
                
                if let countryCode = self?.getCountryCode(),
                    let countryStatistics = self?.statisticsData.getDataByCountry(countryCode: countryCode) {
                    self?.loadCovidNetworking.getDayOne(countryCode: countryStatistics.countryCode) { [weak self] (response) in
                        DispatchQueue.main.async {
                            if let model = response {
                                self?.presenter.didLoadDataByCountry(country: countryStatistics, dayOne: model)
                            } else {
                                self?.presenter.didLoadDataByCountry(country: countryStatistics, dayOne: nil)
                            }
                        }
                    }
                } else {
                    self?.presenter.failure()
                }
            }
        }
    }
    
    func loadDataByGlobal() {
        loadCovidNetworking.getSummary { [weak self] (response) in
            DispatchQueue.main.async {
                if let model = response {
                    self?.globalData.addData(data: model.global, date: model.convertedDate)
                }
                
                if let globalStatistics = self?.globalData.getData() {
                    self?.presenter.didLoadDataByGlobal(global: globalStatistics)
                } else {
                    self?.presenter.failure()
                }
            }
        }
    }
    
    private func getCountryCode() -> String {
        
        if let countryCode = userData.getCountryCode() {
            return countryCode
        } else {
            userData.addCountryCode(countryCode: "RU")
            return userData.getCountryCode()!
        }
    }
}
