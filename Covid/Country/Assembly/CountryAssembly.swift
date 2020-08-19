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
        let view = CountryViewController()
        let presenter = CountryPresenter()
        
        view.presenter = presenter
        presenter.view = view
        
        let loadCovidNetworking = NetworkService()
        let statisticsData = StatisticsData()
        let userData = UserData()
        
        let interactor = CountryInteractor(loadCovidNetworking: loadCovidNetworking, statisticsData: statisticsData, userData: userData, countryCode: countryCode)
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        let router = CountryRouter()
        router.view = view
        presenter.router = router
        
        return view
        
    }
    
}
