//
//  MockMainStatisticsInteractorOutput.swift
//  CovidTests
//
//  Created by Kirill Selivanov on 02.09.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

@testable import Covid

final class MockMainStatisticsInteractorOutput: MainStatisticsInteractorOutput {
    
    var mainStatisticsByCountry: StatisticsModel?
    var mainStatisticsByGlobal: StatisticsModel?
    var error = false
    
    func didLoadMainStatisticsByCountry(statistics: StatisticsModel) {
        mainStatisticsByCountry = statistics
    }
    
    func didLoadMainStatisticsByGlobal(statistics: StatisticsModel) {
        mainStatisticsByGlobal = statistics
    }
    
    func didLoadAllDaysByCountry(allDays: [DayModel]) {
        
    }
    
    func failure() {
        error = true
    }
}
