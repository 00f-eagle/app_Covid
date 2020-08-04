//
//  CountryInteractor.swift
//  Covid
//
//  Created by Kirill Selivanov on 02.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

final class CountryInteractor {
    
    // MARK: - Properties
    
    weak var presenter: CountryInteractorOutput!
    private let statisticsData: StatisticsDataProtocol
    
    // MARK: - Init
    
    init(statisticsData: StatisticsDataProtocol) {
        self.statisticsData = statisticsData
    }
    
}


// MARK: - CountryInteractorInput
extension CountryInteractor: CountryInteractorInput {
    
    func getData(country: String) {
        if let country = statisticsData.getDataByCountry(country: country) {
            presenter.success(statistics: country)
        } else {
            presenter.failure()
        }
    }
}
