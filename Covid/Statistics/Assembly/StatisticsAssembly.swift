//
//  ViewBuilder.swift
//  Covid
//
//  Created by Kirill Selivanov on 14.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class StatisticsAssembly {
    
    static func assembly() -> UIViewController {
        let view = StatisticsViewController()
        let presenter = StatisticsPresenter()
        
        view.presenter = presenter
        presenter.view = view
        
        let statisticsData = StatisticsData()
        let userData = UserData()
        let globalData = GlobalData()
        let networkService = NetworkService()
        
        let interactor = StatisticsInteractor(loadCovidNetworking: networkService, statisticData: statisticsData, userData: userData, globalData: globalData)
        interactor.presenter = presenter
        presenter.interactor = interactor

        let router = StatisticsRouter()
        router.view = view
        presenter.router = router
        
        return view
    }
}
