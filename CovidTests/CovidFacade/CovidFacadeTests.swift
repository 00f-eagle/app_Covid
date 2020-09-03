//
//  CovidFacadeTests.swift
//  CovidTests
//
//  Created by Kirill Selivanov on 03.09.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import XCTest
@testable import Covid

final class CovidFacadeTests: XCTestCase {
    
    private var covidFacade: CovidFacade!
    private var covidNetworking: MockNetworkService!
    private var statisticsData: MockStatisticsData!

    private var summaryModel: SummaryModel?
    
    
    override func setUpWithError() throws {
        covidNetworking = MockNetworkService()
        statisticsData = MockStatisticsData()
        covidFacade = CovidFacade(covidNetworking: covidNetworking, statisticsData: statisticsData)
        
    }

    override func tearDownWithError() throws {
        covidNetworking = nil
        statisticsData = nil
        covidFacade = nil
        summaryModel = nil
    }
    
    func testMainStatisticsByCountrySuccessNetwork() {
        let expectation = XCTestExpectation(description: "getMainStatisticsByCountry")
        
        summaryModel = SummaryModel(global: GlobalModel(newConfirmed: 1,
                                                        totalConfirmed: 2,
                                                        newDeaths: 3,
                                                        totalDeaths: 4,
                                                        newRecovered: 5,
                                                        totalRecovered: 6),
                                    date: "01.01.1970",
                                    countries:[CountryModel(name: "A",
                                                            code: "B",
                                                            newConfirmed: 1,
                                                            totalConfirmed: 2,
                                                            newDeaths: 3,
                                                            totalDeaths: 4,
                                                            newRecovered: 5,
                                                            totalRecovered: 6,
                                                            date: "C")])
        
        covidNetworking.summaryModel = summaryModel
        
        covidFacade.getMainStatisticsByCountry(countryCode: "") { (model) in
            XCTAssertTrue(self.covidNetworking.isCalledGetSummary)
            XCTAssertTrue(self.statisticsData.isCalledAddCountries)
            XCTAssertTrue(self.statisticsData.isCalledGetCountry)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testMainStatisticsByCountryFailureNetwork() {
        let expectation = XCTestExpectation(description: "getMainStatisticsByCountry")
        
        summaryModel = nil
        
        covidNetworking.summaryModel = summaryModel
        
        covidFacade.getMainStatisticsByCountry(countryCode: "") { (model) in
            XCTAssertTrue(self.covidNetworking.isCalledGetSummary)
            XCTAssertFalse(self.statisticsData.isCalledAddCountries)
            XCTAssertTrue(self.statisticsData.isCalledGetCountry)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

}
