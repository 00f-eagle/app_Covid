//
//  ViewBuilder.swift
//  Covid
//
//  Created by Kirill Selivanov on 14.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

protocol Builder {
    static func createStatisticsVM() -> UIViewController
    static func createCountriesVM() -> UIViewController
}

class ViewBuilder: Builder {
    static func createStatisticsVM() -> UIViewController {
        let view = StatisticsViewController()
        let presenter = StatisticsPresenter(view: view)
        view.presenter = presenter
        return view
    }
    
    static func createCountriesVM() -> UIViewController {
        let view = CountriesViewController()
        return view
    }
}
