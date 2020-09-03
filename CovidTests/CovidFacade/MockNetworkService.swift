//
//  MockNetworkService.swift
//  CovidTests
//
//  Created by Kirill Selivanov on 03.09.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit
@testable import Covid

final class MockNetworkService: NetworkServiceProtocol {
    
    var isCalledGetSummary = false
    var isCalledGetAllDays = false
    
    var summaryModel: SummaryModel?
    
    func getSummary(completionHandler: @escaping (SummaryModel?) -> ()) {
        isCalledGetSummary = true
        completionHandler(summaryModel)
    }
    
    func getAllDays(countryCode: String, completionHandler: @escaping ([DayModel]?) -> ()) {
        isCalledGetAllDays = true
    }
}
