//
//  CountriesAssembly.swift
//  Covid
//
//  Created by Kirill Selivanov on 20.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class CountriesAssembly {
    
    static func assembly() -> UIViewController {
        let view = CountriesViewController()
        let presenter = CountriesPresenter()
        
        view.presenter = presenter
        presenter.view = view
        
        let countryData = CountryData()
        
        let interactor = CountriesInteractor(countryData: countryData)
        interactor.presenter = presenter
        presenter.interactor = interactor
        
        let router = CountriesRouter()
        router.view = view
        presenter.router = router
        
        return view
    }
}
