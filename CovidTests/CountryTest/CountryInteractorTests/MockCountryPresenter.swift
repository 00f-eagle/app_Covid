//
//  MockCountryPresenter.swift
//  CovidTests
//
//  Created by Kirill Selivanov on 03.09.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit
@testable import Covid

final class MockCountryPresenter: CountryInteractorOutput {
    
    var isCalledDidLoadMainStatistics = false
    var isCalledDidLoadAllDays = false
    var isCalledDidSetupDefaultCountry = false
    var isCalledFailure = false
    
    func didLoadMainStatistics(statistics: StatisticsModel) {
        isCalledDidLoadMainStatistics = true
    }
    
    func didLoadAllDays(allDays: [DayModel]) {
        isCalledDidLoadAllDays = true
    }
    
    func didSetupDefaultCountry() {
        isCalledDidSetupDefaultCountry = true
    }
    
    func failure() {
        isCalledFailure = true
    }
}
