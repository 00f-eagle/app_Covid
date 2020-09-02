//
//  CountryViewOutput.swift
//  Covid
//
//  Created by Kirill Selivanov on 02.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

protocol CountryViewOutput {
    func getDataByCountry()
    func dismissView()
    func presentFailureAlert(title: String, message: String)
    func setupDefaultCountry()
}
