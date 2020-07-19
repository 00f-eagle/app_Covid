//
//  StatisticsInteractor.swift
//  Covid
//
//  Created by Kirill Selivanov on 17.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class StatisticsInteractor {
    
    // MARK: Properties
    
    weak var presenter: StatisticsInteractorOutput!
}


// MARK: - StatisticsInteractorInput
extension StatisticsInteractor: StatisticsInteractorInput {
    
    func getData() {
        let ns = NetworkService()
        ns.getGlobal { (response) in
            DispatchQueue.main.async {
                if let model = response {
                
                    let numberGlobal  = [
                        model.global.totalConfirmed.formattedWithSeparator,
                        model.global.totalDeaths.formattedWithSeparator,
                        model.global.totalRecovered.formattedWithSeparator,
                        "+\(model.global.newConfirmed.formattedWithSeparator)",
                        "+\(model.global.newDeaths.formattedWithSeparator)",
                        "+\(model.global.newRecovered.formattedWithSeparator)"
                    ]
                    
                    let countriesModel = model.countries.filter({ (Countries) -> Bool in
                        Countries.countryCode == "RU"
                    })
                    
                    let numberCountries  = [
                        countriesModel[0].totalConfirmed.formattedWithSeparator,
                        countriesModel[0].totalDeaths.formattedWithSeparator,
                        countriesModel[0].totalRecovered.formattedWithSeparator,
                        "+\(countriesModel[0].newConfirmed.formattedWithSeparator)",
                        "+\(countriesModel[0].newDeaths.formattedWithSeparator)",
                        "+\(countriesModel[0].newRecovered.formattedWithSeparator)"
                    ]
                    
                    
                    self.presenter.succes(numberGlobal: numberGlobal, numberCountries: numberCountries)
                } else {
                    self.presenter.failure()
                }
            }
        }
    }
}
