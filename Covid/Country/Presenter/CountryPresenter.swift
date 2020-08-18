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
    func changeDefaultCountry() {
        interactor.changeDefaultCountry()
    }
    
    func getData() {
        interactor.loadDataByCountry()
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
    func didLoadDataByCountry(country: Country, dayOne: [DayOneModel]?) {
        let statistics = StatisticsModel(name: country.country, totalConfirmed: Int(country.totalConfirmed), newConfirmed: Int(country.newConfirmed), totalDeaths: Int(country.totalDeaths), newDeaths: Int(country.newDeaths), totalRecovered: Int(country.totalRecovered), newRecovered: Int(country.newRecovered), date: country.date, countryCode: country.countryCode)
        
        guard let dayOne = dayOne else {
            view.success(statistics: statistics, dayOne: nil)
            return
        }
        
        var totalDayOne: [[String: [Int]]] = []
        for day in dayOne {
            totalDayOne.append([day.convertedDate: [day.confirmed, day.deaths, day.recovered]])
        }
        view.success(statistics: statistics, dayOne: totalDayOne)
    }
    
    func failure() {
        view.failure()
    }
}
