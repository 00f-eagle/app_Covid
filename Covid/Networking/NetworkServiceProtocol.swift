//
//  NetworkServiceProtocol.swift
//  Covid
//
//  Created by Kirill Selivanov on 23.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

protocol NetworkServiceProtocol {
    
    func getSummary(completionHandler: @escaping (_ model: [CountryModel]?) -> ())
    func getDayOne(country: String, completionHandler: @escaping (_ model: [DayOneModel]?) -> ())
}
