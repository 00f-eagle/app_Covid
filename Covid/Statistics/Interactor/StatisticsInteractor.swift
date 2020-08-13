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
    private let statisticData: StatisticsDataProtocol
    private let userData: UserDataProtocol
    
    // MARK: - Init
    
    init(loadCovidNetworking: NetworkServiceProtocol, statisticData: StatisticsDataProtocol, userData: UserDataProtocol) {
        self.loadCovidNetworking = loadCovidNetworking
        self.statisticData = statisticData
        self.userData = userData
    }
}


// MARK: - StatisticsInteractorInput
extension StatisticsInteractor: StatisticsInteractorInput {
    
    func loadData() {

        loadCovidNetworking.getSummary { [weak self] (response) in
            DispatchQueue.main.async {
                
                if let model = response {
                    self?.statisticData.addData(data: model)
                }
                
                if let country = self?.getCountry(), let globalStatistics = self?.statisticData.getDataByCountry(country: "World"), let countryStatistics = self?.statisticData.getDataByCountry(country: country) {
                    self?.presenter.success(global: globalStatistics, country: countryStatistics)
                } else {
                    self?.presenter.failure()
                }
            }
        }
        
        loadCovidNetworking.getDayOne(country: getCountry()) { [weak self] (response) in
            DispatchQueue.main.async {
                
                if let model = response {
                    self?.presenter.success2(dayOne: model)
                } else {
                    self?.presenter.failure()
                }
                
            }
        }
    }
    
    private func getCountry() -> String {
        
        if let country = userData.getData() {
            return country
        } else {
            userData.addData(country: "Russian Federation")
            return userData.getData()!
        }
    }
}
