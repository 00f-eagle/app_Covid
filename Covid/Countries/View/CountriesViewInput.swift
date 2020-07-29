//
//  CountriesViewInput.swift
//  Covid
//
//  Created by Kirill Selivanov on 20.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

protocol CountriesViewInput: AnyObject {
    func success(countries: [Statistics])
    func failure()
}
