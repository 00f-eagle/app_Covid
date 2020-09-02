//
//  MainStatisticsInteractorOutput.swift
//  Covid
//
//  Created by Kirill Selivanov on 17.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

protocol MainStatisticsInteractorOutput: AnyObject {
    func didLoadMainStatisticsByCountry(statistics: StatisticsModel)
    func didLoadMainStatisticsByGlobal(statistics: StatisticsModel)
    func didLoadAllDaysByCountry(allDays: [DayModel])
    func failure()
}
