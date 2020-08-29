//
//  MainStatisticsInteractor.swift
//  Covid
//
//  Created by Kirill Selivanov on 17.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class MainStatisticsInteractor {
    
    // MARK: Properties
    
    weak var presenter: MainStatisticsInteractorOutput!
    
    private let covidFacade: CovidFacadeProtocol
    private let userStorage: UserStorageProtocol
    
    // MARK: - Init
    
    init(covidFacade: CovidFacadeProtocol, userStorage: UserStorageProtocol) {
        self.covidFacade = covidFacade
        self.userStorage = userStorage
    }
}


// MARK: - StatisticsInteractorInput
extension MainStatisticsInteractor: MainStatisticsInteractorInput {
    
    func loadStatisticsByCountry() {
        
        let countryCode = getCountryCode()
        
        covidFacade.getAllDaysByCountry(countryCode: countryCode) { [weak self] allDays in
            guard let self = self else { return }
            
            if let allDays = allDays {
                self.presenter.didLoadAllDaysByCountry(allDays: allDays)
            } else {
                self.presenter.failure()
            }
        }
        
        covidFacade.getMainStatisticsByCountry(countryCode: countryCode) { [weak self] statistics in
            guard let self = self else { return }
            
            if let statistics = statistics {
                self.presenter.didLoadMainStatisticsByCountry(statistics: statistics)
            } else {
                self.presenter.failure()
            }
        }
    }
    
    func loadStatisticsByGlobal() {
        
        covidFacade.getMainStatisticsByGlobal { [weak self] statistics in
            guard let self = self else { return }
            
            if let statistics = statistics {
                self.presenter.didLoadMainStatisticsByGlobal(statistics: statistics)
            } else {
                self.presenter.failure()
            }
        }
    }
    
    private func getCountryCode() -> String {
        if let countryCode = userStorage.getCountryCode() {
            return countryCode
        } else {
            let countryCode = "RU"
            userStorage.addCountryCode(countryCode: countryCode)
            return countryCode
        }
    }
}
