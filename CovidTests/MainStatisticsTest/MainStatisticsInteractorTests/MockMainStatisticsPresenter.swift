//
//  MockMainStatisticsPresenter.swift
//  CovidTests
//
//  Created by Kirill Selivanov on 02.09.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

@testable import Covid

final class MockMainStatisticsPresenter: MainStatisticsInteractorOutput {
    
    var isCalledSuccess = false
    var isCalledFailure = false
    
    func didLoadMainStatisticsByCountry(statistics: StatisticsModel) {
        isCalledSuccess = true
    }
    
    func didLoadMainStatisticsByGlobal(statistics: StatisticsModel) {
        isCalledSuccess = true
    }
    
    func didLoadAllDaysByCountry(allDays: [DayModel]) {
        isCalledSuccess = true
    }
    
    func failure() {
        isCalledFailure = true
    }
}
