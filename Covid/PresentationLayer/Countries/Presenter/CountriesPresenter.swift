//
//  CountriesPresenter.swift
//  Covid
//
//  Created by Kirill Selivanov on 20.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class CountriesPresenter {
    
    // MARK: - Properties
    
    weak var view: CountriesViewInput!
    var interactor: CountriesInteractorInput!
    var router: CountriesRouterInput!
    
}


// MARK: - CountriesViewOutput
extension CountriesPresenter: CountriesViewOutput {
    
    func getCountries(searchText: String, status: Status) {
        interactor.loadCountries(searchText: searchText, status: status)
    }
    
    func showCountry(countryCode: String) {
        router.showCountry(countryCode: countryCode)
    }
}


// MARK: - CountriesInteractorOutput
extension CountriesPresenter: CountriesInteractorOutput {
    
    func didLoadCountries(countries: [StatisticsModel], status: Status) {
        let countriesOfStatus = StatisticsOfStatusConverter.convert(statistics: countries, status: status)
        view.presentCountries(countries: countriesOfStatus)
    }
}
