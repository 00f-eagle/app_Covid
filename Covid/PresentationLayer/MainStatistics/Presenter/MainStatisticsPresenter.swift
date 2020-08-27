//
//  MainStatisticsPresenter.swift
//  Covid
//
//  Created by Kirill Selivanov on 14.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class MainStatisticsPresenter {
    
    // MARK: - Properties
    
    weak var view: MainStatisticsViewInput!
    var interactor: MainStatisticsInteractorInput!
    var router: MainStatisticsRouterInput!
    
}


// MARK: - StatisticsViewOutput
extension MainStatisticsPresenter: MainStatisticsViewOutput {
    func presentFailureAlert(title: String, message: String) {
        router.presentFailureAlert(title: title, message: message)
    }
    
    func getDataByCountry() {
        interactor.loadStatisticsByCountry()
    }
    
    func getDataByGlobal() {
        interactor.loadStatisticsByGlobal()
    }
}


// MARK: - StatisticsInteractorOutput
extension MainStatisticsPresenter: MainStatisticsInteractorOutput {
    func didLoadMainStatisticsByCountry(statistics: StatisticsModel) {
        view.presentMainStatisticsByCountry(statistics: statistics)
    }
    
    func didLoadAllDaysByCountry(allDays: [DayModel]) {
        let sortedAllDays = allDays.sorted(by: { $0.convertedDateToDate < $1.convertedDateToDate })
        let graphPointsLog = GraphPointsConverter.convertToGraphPointsLogModel(allDays: sortedAllDays)
        let graphPointsLinConfirmed = GraphPointsConverter.convertToGraphPointsLinModel(allDays: sortedAllDays, status: .confirmed)
        let graphPointsLinDeaths = GraphPointsConverter.convertToGraphPointsLinModel(allDays: sortedAllDays, status: .deaths)
        let graphPointsLinRecovered = GraphPointsConverter.convertToGraphPointsLinModel(allDays: sortedAllDays, status: .recoverded)
        view.presentGraphsByCountry(graphPointsLog: graphPointsLog, graphPointsLinConfirmed: graphPointsLinConfirmed, graphPointsLinDeaths: graphPointsLinDeaths, graphPointsLinRecovered: graphPointsLinRecovered)
    }
    
    func didLoadMainStatisticsByGlobal(statistics: StatisticsModel) {
        view.presentMainStatisticsByGlobal(statistics: statistics)
    }
    
    func failure() {
        view.failure()
    }
}
