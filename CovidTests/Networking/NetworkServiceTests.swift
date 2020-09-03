//
//  NetworkServiceTests.swift
//  CovidTests
//
//  Created by Kirill Selivanov on 03.09.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import XCTest
@testable import Covid

final class NetworkServiceTests: XCTestCase {
    
    private var networkService: NetworkService!

    override func setUpWithError() throws {
        networkService = NetworkService()
    }

    override func tearDownWithError() throws {
        networkService = nil
    }
    
    func testGetSummary() {
        let expectation = XCTestExpectation(description: "Download summary")
        networkService.getSummary { model in
            XCTAssertNotNil(model)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testFailureCountryCode() {
        let expectation = XCTestExpectation(description: "Download allDays")
        networkService.getAllDays(countryCode: "") { model in
            XCTAssertNil(model)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testSuccessCountryCode() {
        let expectation = XCTestExpectation(description: "Download allDays")
        networkService.getAllDays(countryCode: "RU") { model in
            XCTAssertNotNil(model)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }

}
