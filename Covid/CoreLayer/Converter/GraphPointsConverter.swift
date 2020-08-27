//
//  GraphPointsConverter.swift
//  Covid
//
//  Created by Kirill Selivanov on 26.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

struct GraphPointsConverter {
    
    static func convertToGraphPointsLogModel(allDays: [DayModel]) -> [GraphPointsLogModel] {
        var graphPointsLog: [GraphPointsLogModel] = []
        allDays.forEach { day in
            graphPointsLog.append(GraphPointsLogModel(confirmed: day.confirmed, deaths: day.deaths, recovered: day.recovered, date: day.convertedDate))
        }
        return graphPointsLog
    }
    
    static func convertToGraphPointsLinModel(allDays: [DayModel], status: Status) -> [GraphPointsLinModel] {
        guard let firstDay = allDays.first else { return [] }
        var graphPoints: [GraphPointsLinModel] = []
        
        switch status {
        case .confirmed:
            graphPoints.append(GraphPointsLinModel(status: firstDay.confirmed, date: firstDay.convertedDate))
        case .deaths:
            graphPoints.append(GraphPointsLinModel(status: firstDay.deaths, date: firstDay.convertedDate))
        case .recovered:
            graphPoints.append(GraphPointsLinModel(status: firstDay.recovered, date: firstDay.convertedDate))
        }
        
        for index in 1..<allDays.count {
            let dayLast = allDays[index - 1]
            let dayNow = allDays[index]
            
            var newStatus: Int
            
            switch status {
            case .confirmed:
                newStatus = dayNow.confirmed - dayLast.confirmed
            case .deaths:
                newStatus = dayNow.deaths - dayLast.deaths
            case .recovered:
                newStatus = dayNow.recovered - dayLast.recovered
            }
            
            newStatus < 0 ? newStatus = 0 : nil
            graphPoints.append(GraphPointsLinModel(status: newStatus, date: dayNow.convertedDate))
        }
        
        return graphPoints
    }
}
