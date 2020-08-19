//
//  StatisticsPresenter.swift
//  Covid
//
//  Created by Kirill Selivanov on 14.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class StatisticsPresenter {
    
    // MARK: - Properties
    
    weak var view: StatisticsViewInput!
    var interactor: StatisticsInteractorInput!
    var router: StatisticsRouterInput!
    
}


// MARK: - StatisticsViewOutput
extension StatisticsPresenter: StatisticsViewOutput {
    func presentFailureAlert(title: String, message: String) {
        router.presentFailureAlert(title: title, message: message)
    }
    
    func getDataByCountry() {
        interactor.loadDataByCountry()
    }
    
    func getDataByGlobal() {
        interactor.loadDataByGlobal()
    }
}


// MARK: - StatisticsInteractorOutput
extension StatisticsPresenter: StatisticsInteractorOutput {
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
    
    func didLoadDataByGlobal(global: Global) {
        
        let statistics = StatisticsModel(name: global.name, totalConfirmed: Int(global.totalConfirmed), newConfirmed: Int(global.newConfirmed), totalDeaths: Int(global.totalDeaths), newDeaths: Int(global.newDeaths), totalRecovered: Int(global.totalRecovered), newRecovered: Int(global.newRecovered), date: global.date, countryCode: global.code)
        
        view.success(statistics: statistics, dayOne: nil)
    }
    
    func failure() {
        view.failure()
    }
}
