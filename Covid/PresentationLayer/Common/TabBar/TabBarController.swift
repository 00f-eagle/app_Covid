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

        let statisticsViewController = MainStatisticsAssembly.assembly()
        statisticsViewController.tabBarItem = UITabBarItem(title: "Статистика", image: UIImage(named: "statistics.png"), tag: 0)
        
        let countriesViewController = CountriesAssembly.assembly()
        countriesViewController.tabBarItem = UITabBarItem(title: "Все страны", image: UIImage(named: "countries.png"), tag: 1)
        
        let tabBarList = [statisticsViewController, countriesViewController]
        
        tabBar.barTintColor = .clear
        tabBar.backgroundImage = UIImage()
        
        viewControllers = tabBarList
    }
}
