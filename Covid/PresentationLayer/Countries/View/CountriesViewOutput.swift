//
//  CountriesViewOutput.swift
//  Covid
//
//  Created by Kirill Selivanov on 20.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

protocol CountriesViewOutput {
    func getCountries(searchText: String, status: Status)
    func showCountry(countryCode: String)
}
