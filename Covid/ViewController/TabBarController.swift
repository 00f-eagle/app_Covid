//
//  TabBarController.swift
//  Covid
//
//  Created by Kirill Selivanov on 13.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let statisticsViewController = ViewBuilder.createStatisticsVM()
        statisticsViewController.tabBarItem = UITabBarItem(title: "Статистика", image: nil, tag: 0)

        let countriesViewController = ViewBuilder.createCountriesVM()
        countriesViewController.tabBarItem = UITabBarItem(title: "Все страны", image: nil, tag: 1)

        let tabBarList = [statisticsViewController, countriesViewController]
        viewControllers = tabBarList
    }
}
