//
//  CountryAssembly.swift
//  Covid
//
//  Created by Kirill Selivanov on 02.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

class CountryAssembly {
    
    static func assembly(countryCode: String) -> UIViewController {
        let view = CountryView()
        let presenter = CountryPresenter()
        
        view.presenter = presenter
        presenter.view = view
        
        let statisticsData = StatisticsStorage()
        let networkService = NetworkService()
        let covidFacade = CovidFacade(covidNetworking: networkService, statisticsData: statisticsData)
        let userStorage = UserStorage()
        
        let interactor = CountryInteractor(covidFacade: covidFacade, userStorage: userStorage, countryCode: countryCode)
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        let router = CountryRouter()
        router.view = view
        presenter.router = router
        
        return view
    }
}
