//
//  StatisticsRouter.swift
//  Covid
//
//  Created by Kirill Selivanov on 17.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class StatisticsRouter {
    
    // MARK: - Properties
    
    weak var view: StatisticsViewController!
}


// MARK: - StatisticsRouterInput
extension StatisticsRouter: StatisticsRouterInput {
    func exampleForRouter() {
        // Логика переключения view
    }
}
