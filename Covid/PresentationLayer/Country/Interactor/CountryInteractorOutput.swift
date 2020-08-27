//
//  CountryInteractorOutput.swift
//  Covid
//
//  Created by Kirill Selivanov on 02.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

protocol CountryInteractorOutput: AnyObject {
    func didLoadMainStatistics(statistics: StatisticsModel)
    func didLoadAllDays(allDays: [DayModel])
    func didSetupDefaultCountry()
    func failure()
}
