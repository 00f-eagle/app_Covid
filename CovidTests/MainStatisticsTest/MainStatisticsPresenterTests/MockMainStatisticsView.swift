//
//  MockMainStatisticsView.swift
//  CovidTests
//
//  Created by Kirill Selivanov on 02.09.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

@testable import Covid

final class MockMainStatisticsView: MainStatisticsViewInput {
    
    var presenter: MainStatisticsViewOutput!
    
    var mainStatisticsByCountry: StatisticsModel?
    var mainStatisticsByGlobal: StatisticsModel?
    
    func presentMainStatisticsByCountry(statistics: StatisticsModel) {
        mainStatisticsByCountry = statistics
    }
    
    func presentMainStatisticsByGlobal(statistics: StatisticsModel) {
        mainStatisticsByGlobal = statistics
    }
    
    func presentGraphsByCountry(graphPointsLog: [GraphPointsLogModel], graphPointsLinConfirmed: [GraphPointsLineModel], graphPointsLinDeaths: [GraphPointsLineModel], graphPointsLinRecovered: [GraphPointsLineModel]) {

    }
    
    func failure() {
        presenter.presentFailureAlert(title: "", message: "")
    }
}
