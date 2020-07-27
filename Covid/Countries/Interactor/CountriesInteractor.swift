
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
    
    func loadData(status: Status) {
        
        if let countries = statisticsData.getDataByCountries() {
            var countriesSorted: [Statistics]
            switch status {
            case .confirmed:
                countriesSorted = countries.sorted(by: { $0.confirmed > $1.confirmed})
            case .deaths:
                countriesSorted = countries.sorted(by: { $0.deaths > $1.deaths})
            case .recoverded:
                countriesSorted = countries.sorted(by: { $0.recovered > $1.recovered})
            }
            
            presenter.succes(countries: countriesSorted)
        } else {
            presenter.failure()
        }
    }
    
    func seachCountry(text: String, status: Status) {
        
        if let countries = statisticsData.searchData(text: text) {
            var countriesSorted: [Statistics]
            switch status {
            case .confirmed:
                countriesSorted = countries.sorted(by: { $0.confirmed > $1.confirmed})
            case .deaths:
                countriesSorted = countries.sorted(by: { $0.deaths > $1.deaths})
            case .recoverded:
                countriesSorted = countries.sorted(by: { $0.recovered > $1.recovered})
            }
            
            presenter.succes(countries: countriesSorted)
        } else {
            presenter.failure()
        }
    }
    
}

