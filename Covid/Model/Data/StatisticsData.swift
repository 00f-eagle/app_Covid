//
//  StatisticsData.swift
//  Covid
//
//  Created by Kirill Selivanov on 16.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit
import CoreData

protocol StatisticsData {
    
    func add()
    
    func get()
    
    func removeAll()
    
}

final class StatisticsData1 {
    var a = 0
}
