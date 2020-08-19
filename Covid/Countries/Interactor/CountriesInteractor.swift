
//
//  CountriesInteractor.swift
//  Covid
//
//  Created by Kirill Selivanov on 20.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class CountriesInteractor {
    
    // MARK: Properties
    
    weak var presenter: CountriesInteractorOutput!
    private let statisticsData: StatisticsDataProtocol
    
    // MARK: - Init
    
    init(statisticData: StatisticsDataProtocol) {
        self.statisticsData = statisticData
    }
}


// MARK: - StatisticsInteractorInput
extension CountriesInteractor: CountriesInteractorInput {
    
    func loadDataByCountries(status: Status) {
        
        guard let countries = statisticsData.getDataByCountries(), !countries.isEmpty else {
            presenter.failure()
            return
        }
        
        let countriesSorted: [StatisticsModel]
        switch status {
        case .confirmed:
            countriesSorted = countries.sorted(by: { $0.totalConfirmed > $1.totalConfirmed })
        case .deaths:
            countriesSorted = countries.sorted(by: { $0.totalDeaths > $1.totalDeaths })
        case .recoverded:
            countriesSorted = countries.sorted(by: { $0.totalRecovered > $1.totalRecovered })
        }
        
        presenter.success(countries: countriesSorted)
    }
    
    func searchCountry(text: String, status: Status) {
        
        guard let countries = statisticsData.searchData(text: text) else {
            presenter.failure()
            return
        }
        let countriesSorted: [StatisticsModel]
        switch status {
        case .confirmed:
            countriesSorted = countries.sorted(by: { $0.totalConfirmed > $1.totalConfirmed})
        case .deaths:
            countriesSorted = countries.sorted(by: { $0.totalDeaths > $1.totalDeaths})
        case .recoverded:
            countriesSorted = countries.sorted(by: { $0.totalRecovered > $1.totalRecovered})
        }
        
        presenter.success(countries: countriesSorted)
    }
    
}

