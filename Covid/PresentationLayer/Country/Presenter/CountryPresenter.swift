//
//  CountryPresenter.swift
//  Covid
//
//  Created by Kirill Selivanov on 02.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import Foundation

final class CountryPresenter {
    
    // MARK: - Properties
    
    weak var view: CountryViewInput!
    var interactor: CountryInteractorInput!
    var router: CountryRouterInput!

}


//MARK: - CountryViewOutput
extension CountryPresenter: CountryViewOutput {
    func getDataByCountry() {
        interactor.loadStatistics()
    }
    
    func setupDefaultCountry() {
        interactor.setupDefaultCountry()
    }
    
    func dismissView() {
        router.dismissView()
    }
    
    func presentFailureAlert(title: String, message: String) {
        router.presentFailureAlert(title: title, message: message)
    }
}


//MARK: - CountryInteractorOutput
extension CountryPresenter: CountryInteractorOutput {
    
    func didSetupDefaultCountry() {
        NotificationCenter.default.post(name: .didSetupDefaultCountry, object: nil)
    }
    
    func didLoadMainStatistics(statistics: StatisticsModel) {
        view.presetMainStatistics(statistics: statistics)
    }
    
    func didLoadAllDays(allDays: [DayModel]) {
        
        let sortedAllDays = allDays.sorted(by: { $0.convertedDateToDate < $1.convertedDateToDate })
        let graphPointsLog = GraphPointsConverter.convertToGraphPointsLogModel(allDays: sortedAllDays)
        let graphPointsLinConfirmed = GraphPointsConverter.convertToGraphPointsLineModel(allDays: sortedAllDays, status: .confirmed)
        let graphPointsLinDeaths = GraphPointsConverter.convertToGraphPointsLineModel(allDays: sortedAllDays, status: .deaths)
        let graphPointsLinRecovered = GraphPointsConverter.convertToGraphPointsLineModel(allDays: sortedAllDays, status: .recovered)
        view.presentGraphs(graphPointsLog: graphPointsLog, graphPointsLinConfirmed: graphPointsLinConfirmed, graphPointsLinDeaths: graphPointsLinDeaths, graphPointsLinRecovered: graphPointsLinRecovered)
    }
    
    func failure() {
        view.failure()
    }
}
