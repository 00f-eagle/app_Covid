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
    
    private let loadCovidNetworking: NetworkServiceProtocol
    private let statisticData: StatisticsDataProtocol
    
    // MARK: - Init
    
    init(loadCovidNetworking: NetworkServiceProtocol, statisticData: StatisticsDataProtocol) {
        self.loadCovidNetworking = loadCovidNetworking
        self.statisticData = statisticData
    }
}


// MARK: - StatisticsInteractorInput
extension StatisticsInteractor: StatisticsInteractorInput {
    
    func loadData() {

        loadCovidNetworking.getSummary { [weak self] (response) in
            DispatchQueue.main.async {
                
                if let model = response {
                    self?.statisticData.addData(data: model)
                }
                
                if let global = self?.statisticData.getDataByCountry(country: "World"), let country = self?.statisticData.getDataByCountry(country: "Russian Federation") {
                    self?.presenter.success(global: global, country: country)
                } else {
                    self?.presenter.failure()
                }
            }
        }
    }
}
