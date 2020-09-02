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
    private let covidFacade: CovidFacadeProtocol
    private let userStorage: UserStorageProtocol
    private let countryCode: String
    
    // MARK: - Init
    
    init(covidFacade: CovidFacadeProtocol, userStorage: UserStorageProtocol, countryCode: String) {
        self.covidFacade = covidFacade
        self.userStorage = userStorage
        self.countryCode = countryCode
    }
    
}


// MARK: - CountryInteractorInput
extension CountryInteractor: CountryInteractorInput {
    func loadStatistics() {
        
        covidFacade.getAllDaysByCountry(countryCode: countryCode) { [weak self] allDays in
            if let allDays = allDays {
                self?.presenter.didLoadAllDays(allDays: allDays)
            } else {
                self?.presenter.failure()
            }
        }
        
        covidFacade.getMainStatisticsByCountry(countryCode: countryCode) { [weak self] statistics in
            if let statistics = statistics {
                self?.presenter.didLoadMainStatistics(statistics: statistics)
            } else {
                self?.presenter.failure()
            }
        }
    }
    
    
    func setupDefaultCountry() {
        userStorage.addCountryCode(countryCode: countryCode)
        presenter.didSetupDefaultCountry()
    }
}
