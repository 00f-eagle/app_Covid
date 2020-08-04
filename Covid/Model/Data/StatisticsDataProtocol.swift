//
//  StatisticsDataProtocol.swift
//  Covid
//
//  Created by Kirill Selivanov on 23.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

protocol StatisticsDataProtocol {
    
    func addData(data: [CountryModel])
    
    func getDataByCountry(country: String) -> Statistics?
    
    func getDataByCountries() -> [Statistics]?
    
    func searchData(text: String) -> [Statistics]?
    
    func getCountries() -> [String]?
    
    func removeAll()

}
