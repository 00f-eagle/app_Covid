//
//  CountryPresenter.swift
//  Covid
//
//  Created by Kirill Selivanov on 02.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

final class CountryPresenter {
    
    // MARK: - Properties
    
    weak var view: CountryViewInput!
    var interactor: CountryInteractorInput!
    var router: CountryRouterInput!

}


//MARK: = CountryViewOutput
extension CountryPresenter: CountryViewOutput {
    func changeDefaultCountry(country: String) {
        interactor.changeDefaultCountry(country: country)
    }
    
    func loadData(country: String) {
        interactor.getData(country: country)
    }
    
    func dismissView() {
        router.dismissView()
    }
    
    func presentFailureAlert(title: String, message: String) {
        router.presentFailureAlert(title: title, message: message)
    }
}


//MARK: - CountryInteractorOutput
extension CountryPresenter: CountryInteractorOutput {
    
    func success(statistics: Statistics) {
        view.success(statistics: statistics)
    }
    
    func failure() {
        view.failure()
    }
}
