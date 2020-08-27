//
//  MainStatisticsAssembly.swift
//  Covid
//
//  Created by Kirill Selivanov on 14.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class MainStatisticsAssembly {
    
    static func assembly() -> UIViewController {
        let view = MainStatisticsView()
        let presenter = MainStatisticsPresenter()
        
        view.presenter = presenter
        presenter.view = view
        
        let statisticsData = StatisticsStorage()
        let networkService = NetworkService()
        let covidFacade = CovidFacade(covidNetworking: networkService, statisticsData: statisticsData)
        let userStorage = UserStorage()
        
        let interactor = MainStatisticsInteractor(covidFacade: covidFacade, userStorage: userStorage)
        interactor.presenter = presenter
        presenter.interactor = interactor

        let router = MainStatisticsRouter()
        router.view = view
        presenter.router = router
        
        return view
    }
}
