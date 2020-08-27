//
//  MainStatisticsViewInput.swift
//  Covid
//
//  Created by Kirill Selivanov on 16.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

protocol MainStatisticsViewInput: AnyObject {
    func presentMainStatisticsByCountry(statistics: StatisticsModel)
    func presentMainStatisticsByGlobal(statistics: StatisticsModel)
    func presentGraphsByCountry(graphPointsLog: [GraphPointsLogModel], graphPointsLinConfirmed: [GraphPointsLinModel], graphPointsLinDeaths: [GraphPointsLinModel], graphPointsLinRecovered: [GraphPointsLinModel])
    func failure()
}
