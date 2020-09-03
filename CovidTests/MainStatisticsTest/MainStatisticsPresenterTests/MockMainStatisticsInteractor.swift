//
//  MockMainStatisticsInteractor.swift
//  CovidTests
//
//  Created by Kirill Selivanov on 02.09.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

@testable import Covid

final class MockMainStatisticsInteractor: MainStatisticsInteractorInput {
    
    var presenter: MainStatisticsInteractorOutput!
    
    var mainStatisticsByCountry: StatisticsModel?
    var mainStatisticsByGlobal: StatisticsModel?
    
    func loadStatisticsByCountry() {
        if let mainStatisticsByCountry = mainStatisticsByCountry {
            presenter.didLoadMainStatisticsByCountry(statistics: mainStatisticsByCountry)
        } else {
            presenter.failure()
        }
    }
    
    func loadStatisticsByGlobal() {
        if let mainStatisticsByGlobal = mainStatisticsByGlobal {
            presenter.didLoadMainStatisticsByGlobal(statistics: mainStatisticsByGlobal)
        } else {
            presenter.failure()
        }
    }
}
