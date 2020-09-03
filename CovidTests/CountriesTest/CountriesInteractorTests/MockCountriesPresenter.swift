//
//  MockCountriesPresenter.swift
//  CovidTests
//
//  Created by Kirill Selivanov on 03.09.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit
@testable import Covid

final class MockCountriesPresenter: CountriesInteractorOutput {
    
    var isCalled = false
    
    func didLoadCountries(countries: [StatisticsModel], status: Status) {
        isCalled = true
    }
}
