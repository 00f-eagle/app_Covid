//
//  ConverterTests.swift
//  CovidTests
//
//  Created by Kirill Selivanov on 03.09.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import XCTest
@testable import Covid

final class ConverterTests: XCTestCase {
    
    private let days = [DayModel(confirmed: 1, deaths: 2, recovered: 3, date: "01.01.1970")]
    private let statisticsModels = [StatisticsModel(name: "A", totalConfirmed: 0, newConfirmed: 1, totalDeaths: 2, newDeaths: 3, totalRecovered: 4, newRecovered: 5, date: "B", code: "C")]

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testConvertToGraphPointsLogModel() {
        let graphPointsLogModel = GraphPointsConverter.convertToGraphPointsLogModel(allDays: days)
        XCTAssertEqual(days.first?.confirmed, graphPointsLogModel.first?.confirmed)
        XCTAssertEqual(days.first?.deaths, graphPointsLogModel.first?.deaths)
        XCTAssertEqual(days.first?.recovered, graphPointsLogModel.first?.recovered)
        XCTAssertEqual(days.first?.convertedDate, graphPointsLogModel.first?.date)
    }
    
    func testConvertToGraphPointsLineModel() {
        let graphPointsLineModelConfirmed = GraphPointsConverter.convertToGraphPointsLineModel(allDays: days, status: .confirmed)
        XCTAssertEqual(days.first?.confirmed, graphPointsLineModelConfirmed.first?.status)
        XCTAssertEqual(days.first?.convertedDate, graphPointsLineModelConfirmed.first?.date)
        let graphPointsLineModelDeaths = GraphPointsConverter.convertToGraphPointsLineModel(allDays: days, status: .deaths)
        XCTAssertEqual(days.first?.deaths, graphPointsLineModelDeaths.first?.status)
        XCTAssertEqual(days.first?.convertedDate, graphPointsLineModelDeaths.first?.date)
        let graphPointsLineModelRecovered = GraphPointsConverter.convertToGraphPointsLineModel(allDays: days, status: .recovered)
        XCTAssertEqual(days.first?.recovered, graphPointsLineModelRecovered.first?.status)
        XCTAssertEqual(days.first?.convertedDate, graphPointsLineModelRecovered.first?.date)
    }
    
    func testConvertStatisticsModelToStatisticsOfStatus() {
        
        let statisticsOfStatusConfirmed = StatisticsOfStatusConverter.convert(statistics: statisticsModels, status: .confirmed)
        XCTAssertEqual(statisticsModels.first?.totalConfirmed, statisticsOfStatusConfirmed.first?.total)
        XCTAssertEqual(statisticsModels.first?.newConfirmed, statisticsOfStatusConfirmed.first?.new)
        XCTAssertEqual(statisticsModels.first?.name, statisticsOfStatusConfirmed.first?.name)
        XCTAssertEqual(statisticsModels.first?.code, statisticsOfStatusConfirmed.first?.code)
        
        let statisticsOfStatusDeaths = StatisticsOfStatusConverter.convert(statistics: statisticsModels, status: .deaths)
        XCTAssertEqual(statisticsModels.first?.totalDeaths, statisticsOfStatusDeaths.first?.total)
        XCTAssertEqual(statisticsModels.first?.newDeaths, statisticsOfStatusDeaths.first?.new)
        XCTAssertEqual(statisticsModels.first?.name, statisticsOfStatusDeaths.first?.name)
        XCTAssertEqual(statisticsModels.first?.code, statisticsOfStatusDeaths.first?.code)
        
        let statisticsOfStatusRecovered = StatisticsOfStatusConverter.convert(statistics: statisticsModels, status: .recovered)
        XCTAssertEqual(statisticsModels.first?.totalRecovered, statisticsOfStatusRecovered.first?.total)
        XCTAssertEqual(statisticsModels.first?.newRecovered, statisticsOfStatusRecovered.first?.new)
        XCTAssertEqual(statisticsModels.first?.name, statisticsOfStatusRecovered.first?.name)
        XCTAssertEqual(statisticsModels.first?.code, statisticsOfStatusRecovered.first?.code)
    }
}
