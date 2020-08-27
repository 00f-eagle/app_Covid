//
//  MainStatisticsRouter.swift
//  Covid
//
//  Created by Kirill Selivanov on 17.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class MainStatisticsRouter {
    
    // MARK: - Properties
    
    weak var view: MainStatisticsView!
}


// MARK: - StatisticsRouterInput
extension MainStatisticsRouter: MainStatisticsRouterInput {
    func presentFailureAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
}
