//
//  CountryViewInput.swift
//  Covid
//
//  Created by Kirill Selivanov on 02.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

protocol CountryViewInput: AnyObject {
    func presetMainStatistics(statistics: StatisticsModel)
    func presentGraphs(graphPointsLog: [GraphPointsLogModel], graphPointsLinConfirmed: [GraphPointsLinModel], graphPointsLinDeaths: [GraphPointsLinModel], graphPointsLinRecovered: [GraphPointsLinModel])
    func failure()
}
