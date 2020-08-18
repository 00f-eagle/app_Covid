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

    func loadData(text: String, status: Status) {
        if text.isEmpty {
            interactor.getData(status: status)
        }
        else {
            interactor.searchCountry(text: text, status: status)
        }
    }
    
    func showCountry(countryCode: String) {
        router.showCountry(countryCode: countryCode)
    }
    
    func presentFailureAlert(title: String, message: String) {
        router.presentFailureAlert(title: title, message: message)
    }
}


// MARK: - CountriesInteractorOutput
extension CountriesPresenter: CountriesInteractorOutput {
    
    func success(countries: [Country]) {
        
        let statistics = countries.map { StatisticsModel(name: $0.country, totalConfirmed: Int($0.totalConfirmed), newConfirmed: Int($0.newConfirmed), totalDeaths: Int($0.totalDeaths), newDeaths: Int($0.newDeaths), totalRecovered: Int($0.totalRecovered), newRecovered: Int($0.newRecovered), date: $0.date, countryCode: $0.countryCode) }
    
        
        view.success(statistics: statistics)
    }
    
    func failure() {
        view.failure()
    }
}
