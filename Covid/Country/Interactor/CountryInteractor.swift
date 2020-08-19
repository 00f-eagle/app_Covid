//
//  CountryInteractor.swift
//  Covid
//
//  Created by Kirill Selivanov on 02.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class CountryInteractor {
    
    // MARK: - Properties
    
    weak var presenter: CountryInteractorOutput!
    private let loadCovidNetworking: NetworkServiceProtocol
    private let statisticsData: StatisticsDataProtocol
    private let userData: UserDataProtocol
    private let countryCode: String
    
    // MARK: - Init
    
    init(loadCovidNetworking: NetworkServiceProtocol, statisticsData: StatisticsDataProtocol, userData: UserDataProtocol, countryCode: String) {
        self.loadCovidNetworking = loadCovidNetworking
        self.statisticsData = statisticsData
        self.userData = userData
        self.countryCode = countryCode
    }
    
}


// MARK: - CountryInteractorInput
extension CountryInteractor: CountryInteractorInput {
    
    func changeDefaultCountry() {
        userData.addCountryCode(countryCode: countryCode)
    }
    
    func loadDataByCountry() {
        
        if let countryStatistics = statisticsData.getDataByCountry(countryCode: countryCode) {
            loadCovidNetworking.getDayOne(countryCode: countryStatistics.countryCode) { [weak self] (response) in
                DispatchQueue.main.async {
                    if let model = response {
                        self?.presenter.didLoadDataByCountry(country: countryStatistics, dayOne: model)
                    } else {
                        self?.presenter.didLoadDataByCountry(country: countryStatistics, dayOne: nil)
                    }
                }
            }
        } else {
            presenter.failure()
        }
    }
}
