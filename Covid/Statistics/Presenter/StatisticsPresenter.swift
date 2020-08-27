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
    func didLoadDataByCountry(country: StatisticsModel, dayOne: [DayOneModel]?) {
        
        guard let dayOne = dayOne else {
            view.success(statistics: country, dayOne: nil)
            return
        }
        
        var totalDayOne: [[String: [Int]]] = []
        for day in dayOne {
            totalDayOne.append([day.convertedDate: [day.confirmed, day.deaths, day.recovered]])
        }
        view.success(statistics: country, dayOne: totalDayOne)
    }
    
    func didLoadDataByGlobal(global: StatisticsModel) {
        view.success(statistics: global, dayOne: nil)
    }
    
    func failure() {
        view.failure()
    }
}
