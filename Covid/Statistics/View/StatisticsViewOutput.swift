//
//  StatisticsViewOutput.swift
//  Covid
//
//  Created by Kirill Selivanov on 16.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

protocol StatisticsViewOutput: AnyObject {
    func updateView()
    func exampleForRouter()
}
