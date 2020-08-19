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
    private let countryData: CountryDataProtocol
    private let userData: UserDataProtocol
    private let countryCode: String
    
    // MARK: - Init
    
    init(loadCovidNetworking: NetworkServiceProtocol, countryData: CountryDataProtocol, userData: UserDataProtocol, countryCode: String) {
        self.loadCovidNetworking = loadCovidNetworking
        self.countryData = countryData
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
        
        if let countryStatistics = countryData.getDataByCountry(countryCode: countryCode) {
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
