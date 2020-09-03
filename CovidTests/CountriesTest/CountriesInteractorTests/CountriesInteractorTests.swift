//
//  CountriesInteractorTests.swift
//  CovidTests
//
//  Created by Kirill Selivanov on 03.09.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import XCTest
@testable import Covid

final class CountriesInteractorTests: XCTestCase {
    
    private var interactor: CountriesInteractor!
    private var statisticsData: MockStatisticsData!
    private var presenter: MockCountriesPresenter!
    
    override func setUpWithError() throws {
        presenter = MockCountriesPresenter()
        statisticsData = MockStatisticsData()
        interactor = CountriesInteractor(statisticsData: statisticsData)
        interactor.presenter = presenter
    }
    
    override func tearDownWithError() throws {
        interactor = nil
        presenter = nil
        statisticsData = nil
    }
    
    func testLoadCountriesWithCorrectedStatisticsData() {
        statisticsData.countries = []
        interactor.loadCountries(searchText: "", status: .confirmed)
        XCTAssertTrue(statisticsData.isCalledGetCountries)
        XCTAssertTrue(presenter.isCalledDidLoadCountries)
    }
    
    func testLoadCountriesWithFailureStatisticsData() {
        statisticsData.countries = nil
        interactor.loadCountries(searchText: "", status: .confirmed)
        XCTAssertTrue(statisticsData.isCalledGetCountries)
        XCTAssertFalse(presenter.isCalledDidLoadCountries)
    }
    
}
