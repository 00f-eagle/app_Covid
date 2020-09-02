//
//  MainStatisticsViewOutput.swift
//  Covid
//
//  Created by Kirill Selivanov on 16.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

protocol MainStatisticsViewOutput {
    func getDataByCountry()
    func getDataByGlobal()
    func presentFailureAlert(title: String, message: String)
}
