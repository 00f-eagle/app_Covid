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
    
    var networkService = NetworkService()
    var statisticsData = StatisticsStorage()
    
    func getMainStatisticsByCountry(countryCode: String, completionHandler: @escaping (StatisticsModel?) -> Void) {
        
    }
    
    func getAllDaysByCountry(countryCode: String, completionHandler: @escaping ([DayModel]?) -> Void) {
        
    }
    
    func getMainStatisticsByGlobal(completionHandler: @escaping (StatisticsModel?) -> Void) {
        
    }
}
