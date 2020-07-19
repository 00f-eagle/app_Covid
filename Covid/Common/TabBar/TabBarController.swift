//
//  TabBarController.swift
//  Covid
//
//  Created by Kirill Selivanov on 13.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let statisticsViewController = StatisticsAssembly.assembly()
        statisticsViewController.tabBarItem = UITabBarItem(title: "Статистика", image: nil, tag: 0)
        statisticsViewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -15)
        
        let countriesViewController = CountriesViewController()
        countriesViewController.tabBarItem = UITabBarItem(title: "Все страны", image: nil, tag: 1)
        countriesViewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -15)
        
        let tabBarList = [statisticsViewController, countriesViewController]
        
        tabBar.barTintColor = Colors.black
        viewControllers = tabBarList
    }
}
