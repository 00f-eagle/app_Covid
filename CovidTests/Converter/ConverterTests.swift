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
    
    let day = DayModel(confirmed: 100, deaths: 200, recovered: 300, date: "02.09.2020")

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testConvertToGraphPointsLogModel() {
        let graphPointsLogModel = GraphPointsConverter.convertToGraphPointsLogModel(allDays: [day])
        XCTAssertEqual(day.confirmed, graphPointsLogModel.first?.confirmed)
        XCTAssertEqual(day.deaths, graphPointsLogModel.first?.deaths)
        XCTAssertEqual(day.recovered, graphPointsLogModel.first?.recovered)
        XCTAssertEqual(day.convertedDate, graphPointsLogModel.first?.date)
    }
    
    func testConvertToGraphPointsLineModel() {
        let graphPointsLineModelConfirmed = GraphPointsConverter.convertToGraphPointsLineModel(allDays: [day], status: .confirmed)
        XCTAssertEqual(day.confirmed, graphPointsLineModelConfirmed.first?.status)
        XCTAssertEqual(day.convertedDate, graphPointsLineModelConfirmed.first?.date)
        let graphPointsLineModelDeaths = GraphPointsConverter.convertToGraphPointsLineModel(allDays: [day], status: .deaths)
        XCTAssertEqual(day.deaths, graphPointsLineModelDeaths.first?.status)
        XCTAssertEqual(day.convertedDate, graphPointsLineModelDeaths.first?.date)
        let graphPointsLineModelRecovered = GraphPointsConverter.convertToGraphPointsLineModel(allDays: [day], status: .recovered)
        XCTAssertEqual(day.recovered, graphPointsLineModelRecovered.first?.status)
        XCTAssertEqual(day.convertedDate, graphPointsLineModelRecovered.first?.date)
    }
}
