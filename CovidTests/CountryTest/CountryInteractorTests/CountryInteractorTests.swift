//
//  CountryInteractorTests.swift
//  CovidTests
//
//  Created by Kirill Selivanov on 03.09.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import XCTest
@testable import Covid

final class CountryInteractorTests: XCTestCase {
    
    private var interactor: CountryInteractor!
    private var covidFacade: MockCovidFacade!
    private var userStorage: MockUserStorage!
    private var presenter: MockCountryPresenter!
    private var countryCode: String!

    override func setUpWithError() throws {
        covidFacade = MockCovidFacade()
        userStorage = MockUserStorage()
        presenter = MockCountryPresenter()
        countryCode = "RU"
        interactor = CountryInteractor(covidFacade: covidFacade, userStorage: userStorage, countryCode: countryCode)
        interactor.presenter = presenter
    }

    override func tearDownWithError() throws {
        covidFacade = nil
        interactor = nil
        userStorage = nil
        presenter = nil
        countryCode = nil
    }
    
    func testWhereSuccessLoadStatisticsByCountry() {
        covidFacade.statisticsModelByCountry = StatisticsModel(name: "Afghanistan", totalConfirmed: 38196, newConfirmed: 31, totalDeaths: 1406, newDeaths: 4, totalRecovered: 29231, newRecovered: 142, date: "02.09.2020", code: "AF")
        interactor.loadStatistics()
        XCTAssertTrue(presenter.isCalledDidLoadMainStatistics)
        XCTAssertFalse(presenter.isCalledFailure)
    }
    
    func testWhereFailureLoadStatisticsByCountry() {
        covidFacade.statisticsModelByCountry = nil
        interactor.loadStatistics()
        XCTAssertFalse(presenter.isCalledDidLoadMainStatistics)
        XCTAssertTrue(presenter.isCalledFailure)
    }
    
    func testWhereFailureLoadStatisticsByGlobal() {
        covidFacade.statisticsModelByCountry = nil
        interactor.setupDefaultCountry()
        XCTAssertEqual(userStorage.countryCode, countryCode)
        XCTAssertTrue(presenter.isCalledDidSetupDefaultCountry)
        XCTAssertFalse(presenter.isCalledFailure)
    }

}
