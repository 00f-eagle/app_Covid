//
//  StatisticsOfStatusConverter.swift
//  Covid
//
//  Created by Kirill Selivanov on 26.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class StatisticsOfStatusConverter {
    
    static func convert(statistics: [StatisticsModel], status: Status) -> [StatisticsOfStatusModel] {
        
        let statisticsSorted: [StatisticsModel]
        switch status {
        case .confirmed:
            statisticsSorted = statistics.sorted(by: { $0.totalConfirmed > $1.totalConfirmed})
        case .deaths:
            statisticsSorted = statistics.sorted(by: { $0.totalDeaths > $1.totalDeaths})
        case .recoverded:
            statisticsSorted = statistics.sorted(by: { $0.totalRecovered > $1.totalRecovered})
        }
        
        var statisticsOfStatus: [StatisticsOfStatusModel] = []
        statisticsSorted.forEach { model in
            switch status {
            case .confirmed:
                statisticsOfStatus.append(StatisticsOfStatusModel(name: model.name, total: model.totalConfirmed, new: model.newConfirmed, code: model.code))
            case .deaths:
                statisticsOfStatus.append(StatisticsOfStatusModel(name: model.name, total: model.totalDeaths, new: model.newDeaths, code: model.code))
            case .recoverded:
                statisticsOfStatus.append(StatisticsOfStatusModel(name: model.name, total: model.totalRecovered, new: model.newRecovered, code: model.code))
            }
        }
        return statisticsOfStatus
    }

}
