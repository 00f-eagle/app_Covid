//
//  MockMainStatisticsRouter.swift
//  CovidTests
//
//  Created by Kirill Selivanov on 02.09.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

@testable import Covid

final class MockMainStatisticsRouter: MainStatisticsRouterInput {
    
    var showAlert = false
    
    func presentFailureAlert(title: String, message: String) {
        showAlert = true
    }
}
