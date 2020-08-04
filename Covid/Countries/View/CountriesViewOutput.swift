//
//  CountriesViewOutput.swift
//  Covid
//
//  Created by Kirill Selivanov on 20.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

protocol CountriesViewOutput {
    func loadData(text: String, status: Status)
    func presentFailureAlert(title: String, message: String)
    func showCountry(country: String)
}
