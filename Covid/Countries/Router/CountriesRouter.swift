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
    
    weak var view: CountriesViewController!
}



// MARK: - StatisticsRouterInput
extension CountriesRouter: CountriesRouterInput {
    func showCountry(country: String) {
        let country = CountryAssembly.assembly(country: country)
        country.modalPresentationStyle = .fullScreen
        view.present(country, animated: true, completion: nil)
    }
    
    func presentFailureAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
}
