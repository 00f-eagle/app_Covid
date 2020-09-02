
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
    private let statisticsData: StatisticsStorageProtocol
    
    // MARK: - Init
    
    init(statisticsData: StatisticsStorageProtocol) {
        self.statisticsData = statisticsData
    }
}


// MARK: - StatisticsInteractorInput
extension CountriesInteractor: CountriesInteractorInput {
    
    func loadCountries(searchText: String, status: Status) {
        guard let countries = statisticsData.getCountries(searchText: searchText) else { return }
        presenter.didLoadCountries(countries: countries, status: status)
    }
}

