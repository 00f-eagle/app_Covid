//
//  MockCovidFacade.swift
//  CovidTests
//
//  Created by Kirill Selivanov on 02.09.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit
@testable import Covid

final class MockCovidFacade: CovidFacadeProtocol {
    
    var statisticsModelByCountry: StatisticsModel?
    var statisticsModelByGlobal: StatisticsModel?
    
    func getMainStatisticsByCountry(countryCode: String, completionHandler: @escaping (StatisticsModel?) -> Void) {
        
        if let statisticsModel = statisticsModelByCountry {
            completionHandler(statisticsModel)
        } else {
            completionHandler(nil)
        }
        
    }
    
    func getAllDaysByCountry(countryCode: String, completionHandler: @escaping ([DayModel]?) -> Void) {
        
    }
    
    func getMainStatisticsByGlobal(completionHandler: @escaping (StatisticsModel?) -> Void) {
        if let statisticsModel = statisticsModelByGlobal {
            completionHandler(statisticsModel)
        } else {
            completionHandler(nil)
        }
    }
}
