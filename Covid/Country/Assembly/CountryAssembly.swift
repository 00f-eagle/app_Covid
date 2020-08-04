//
//  CountryAssembly.swift
//  Covid
//
//  Created by Kirill Selivanov on 02.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

class CountryAssembly {
    
    static func assembly(country: String) -> UIViewController {
        let view = CountryViewController()
        let presenter = CountryPresenter()
        
        view.country = country
        view.presenter = presenter
        presenter.view = view
        
        let statisticsData = StatisticsData()
        let userData = UserData()
        
        let interactor = CountryInteractor(statisticsData: statisticsData, userData: userData)
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        let router = CountryRouter()
        router.view = view
        presenter.router = router
        
        return view
        
    }
    
}
