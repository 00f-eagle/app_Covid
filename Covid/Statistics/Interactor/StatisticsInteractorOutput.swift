//
//  StatisticsInteractorOutput.swift
//  Covid
//
//  Created by Kirill Selivanov on 17.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

protocol StatisticsInteractorOutput: AnyObject {
    func success(global: Statistics, country: Statistics)
    func success2(dayOne: [DayOneModel])
    func failure()
}
