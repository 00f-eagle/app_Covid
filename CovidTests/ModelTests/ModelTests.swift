//
//  ModelTests.swift
//  CovidTests
//
//  Created by Kirill Selivanov on 02.09.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import XCTest
@testable import Covid

final class ModelTests: XCTestCase {
    
    private var statisticsModel: StatisticsModel!
    private var globalModel: GlobalModel!
    private var countryModel: CountryModel!

    override func setUpWithError() throws {
        statisticsModel = StatisticsModel(name: "Afghanistan", totalConfirmed: 38196, newConfirmed: 31, totalDeaths: 1406, newDeaths: 4, totalRecovered: 29231, newRecovered: 142, date: "02.09.2020", code: "AF")
        globalModel = GlobalModel(newConfirmed: 264767, totalConfirmed: 25746235, newDeaths: 6478, totalDeaths: 856969, newRecovered: 254664, totalRecovered: 17072595)
        countryModel = CountryModel(name: "Afghanistan", code: "AF", newConfirmed: 31, totalConfirmed: 38196, newDeaths: 4, totalDeaths: 1406, newRecovered: 142, totalRecovered: 29231, date: "2020-09-02T08:47:27Z")
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        statisticsModel = nil
        globalModel = nil
        countryModel = nil
    }
    
    func testStatisticsModel() {
        XCTAssertEqual(statisticsModel.name, "Afghanistan")
        XCTAssertEqual(statisticsModel.totalConfirmed, 38196)
        XCTAssertEqual(statisticsModel.newConfirmed, 31)
        XCTAssertEqual(statisticsModel.totalDeaths, 1406)
        XCTAssertEqual(statisticsModel.newDeaths, 4)
        XCTAssertEqual(statisticsModel.totalRecovered, 29231)
        XCTAssertEqual(statisticsModel.newRecovered, 142)
        XCTAssertEqual(statisticsModel.date, "02.09.2020")
        XCTAssertEqual(statisticsModel.code, "AF")
    }
    
    func testGlobalModel() {
        XCTAssertEqual(globalModel.totalConfirmed, 25746235)
        XCTAssertEqual(globalModel.newConfirmed, 264767)
        XCTAssertEqual(globalModel.totalDeaths, 856969)
        XCTAssertEqual(globalModel.newDeaths, 6478)
        XCTAssertEqual(globalModel.totalRecovered, 17072595)
        XCTAssertEqual(globalModel.newRecovered, 254664)
    }
    
    func testCountryModel() {
        XCTAssertEqual(countryModel.name, "Afghanistan")
        XCTAssertEqual(countryModel.totalConfirmed, 38196)
        XCTAssertEqual(countryModel.newConfirmed, 31)
        XCTAssertEqual(countryModel.totalDeaths, 1406)
        XCTAssertEqual(countryModel.newDeaths, 4)
        XCTAssertEqual(countryModel.totalRecovered, 29231)
        XCTAssertEqual(countryModel.newRecovered, 142)
        XCTAssertEqual(countryModel.date, "2020-09-02T08:47:27Z")
        XCTAssertEqual(countryModel.code, "AF")
    }

}
