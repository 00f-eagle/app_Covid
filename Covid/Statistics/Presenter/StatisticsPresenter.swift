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
    var iteractor: StatisticsIteractorInput!
    var router: StatisticsRouterInput!
    
}


// MARK: - StatisticsViewOutput
extension StatisticsPresenter: StatisticsViewOutput {
    
    func updateView() {
        iteractor.getData()
    }
    
    func exampleForRouter() {
        router.exampleForRouter()
    }
}


// MARK: - StatisticsInteractorOutput
extension StatisticsPresenter: StatisticsIteractorOutput {
    
    func succes(numberGlobal: [String], numberCountries: [String]) {
        view.succes(numberGlobal: numberGlobal, numberCountries: numberCountries)
    }
    
    func failure() {
        view.failure()
    }
}
