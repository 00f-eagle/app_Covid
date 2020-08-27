//
//  CountriesRouter.swift
//  Covid
//
//  Created by Kirill Selivanov on 20.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class CountriesRouter {
    
    // MARK: - Properties
    
    weak var view: CountriesView!
}


// MARK: - StatisticsRouterInput
extension CountriesRouter: CountriesRouterInput {
    func showCountry(countryCode: String) {
        let country = CountryAssembly.assembly(countryCode: countryCode)
        country.modalPresentationStyle = .fullScreen
        view.present(country, animated: true, completion: nil)
    }
}
