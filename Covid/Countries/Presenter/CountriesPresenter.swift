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
    
    func showCountry(country: String) {
        router.showCountry(country: country)
    }
    
    func presentFailureAlert(title: String, message: String) {
        router.presentFailureAlert(title: title, message: message)
    }
}


// MARK: - CountriesInteractorOutput
extension CountriesPresenter: CountriesInteractorOutput {
    
    func success(countries: [Statistics]) {
        view.success(countries: countries)
    }
    
    func failure() {
        view.failure()
    }
}
