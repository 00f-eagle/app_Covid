//
//  CountryInteractorOutput.swift
//  Covid
//
//  Created by Kirill Selivanov on 02.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

protocol CountryInteractorOutput: AnyObject {
    func success(statistics: Statistics)
    func failure()
}
