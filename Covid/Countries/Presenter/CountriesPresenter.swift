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
    
    func searchCountry(text: String, status: Status) {
        interactor.seachCountry(text: text, status: status)
    }

    func loadData(status: Status) {
        interactor.loadData(status: status)
    }
    
    func presentFailureAlert(title: String, message: String) {
        router.presentFailureAlert(title: title, message: message)
    }
}


// MARK: - CountriesInteractorOutput
extension CountriesPresenter: CountriesInteractorOutput {
    
    func succes(countries: [Statistics]) {
        view.succes(countries: countries)
    }
    
    func failure() {
        view.failure()
    }
}
