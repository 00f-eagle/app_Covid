//
//  StatisticsInteractorOutput.swift
//  Covid
//
//  Created by Kirill Selivanov on 17.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

protocol StatisticsInteractorOutput: AnyObject {
    func didLoadDataByCountry(country: Country, dayOne: [DayOneModel]?)
    func didLoadDataByGlobal(global: Global)
    func failure()
}
