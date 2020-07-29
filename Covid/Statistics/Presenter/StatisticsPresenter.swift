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
    
    func changeCountry() {
        router.showCountry()
    }
    
    func getData() {
        interactor.loadData()
    }
}


// MARK: - StatisticsInteractorOutput
extension StatisticsPresenter: StatisticsInteractorOutput {
    
    func success(global: Statistics, country: Statistics) {
        view.succes(global: global, country: country)
    }
    
    func failure() {
        view.failure()
    }
}
