//
//  MainStatisticsInteractorTests.swift
//  CovidTests
//
//  Created by Kirill Selivanov on 02.09.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import XCTest
@testable import Covid

final class MainStatisticsInteractorTests: XCTestCase {
    
    private var interactor: MainStatisticsInteractor!
    private var presenter: MockMainStatisticsInteractorOutput!
    private var covidFacade: MockCovidFacade!
    private var userStorage: MockUserStorage!

    override func setUpWithError() throws {
        covidFacade = MockCovidFacade()
        userStorage = MockUserStorage()
        presenter = MockMainStatisticsInteractorOutput()
        interactor = MainStatisticsInteractor(covidFacade: covidFacade, userStorage: userStorage)
        interactor.presenter = presenter
    }

    override func tearDownWithError() throws {
        interactor = nil
        presenter = nil
        covidFacade = nil
        userStorage = nil
    }
    
    func testWhereSuccessLoadStatisticsByCountry() {
        covidFacade.statisticsModelByCountry = StatisticsModel(name: "Afghanistan", totalConfirmed: 38196, newConfirmed: 31, totalDeaths: 1406, newDeaths: 4, totalRecovered: 29231, newRecovered: 142, date: "02.09.2020", code: "AF")
        interactor.loadStatisticsByCountry()
        XCTAssertTrue(presenter.isCalledSuccess)
        XCTAssertFalse(presenter.isCalledFailure)
    }
    
    func testWhereSuccessLoadStatisticsByGlobal() {
        covidFacade.statisticsModelByGlobal = StatisticsModel(name: "World", totalConfirmed: 25746235, newConfirmed: 264767, totalDeaths: 856969, newDeaths: 6478, totalRecovered: 17072595, newRecovered: 254664, date: "02.09.2020", code: "World")
        interactor.loadStatisticsByGlobal()
        XCTAssertTrue(presenter.isCalledSuccess)
        XCTAssertFalse(presenter.isCalledFailure)
    }
    
    func testWhereFailureLoadStatisticsByCountry() {
        covidFacade.statisticsModelByCountry = nil
        interactor.loadStatisticsByCountry()
        XCTAssertFalse(presenter.isCalledSuccess)
        XCTAssertTrue(presenter.isCalledFailure)
    }
    
    func testWhereFailureLoadStatisticsByGlobal() {
        covidFacade.statisticsModelByCountry = nil
        interactor.loadStatisticsByGlobal()
        XCTAssertFalse(presenter.isCalledSuccess)
        XCTAssertTrue(presenter.isCalledFailure)
    }
}
