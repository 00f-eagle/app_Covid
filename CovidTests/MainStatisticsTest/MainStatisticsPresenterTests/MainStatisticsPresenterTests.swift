//
//  MainStatisticsPresenterTests.swift
//  CovidTests
//
//  Created by Kirill Selivanov on 02.09.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import XCTest
@testable import Covid

final class MainStatisticsPresenterTests: XCTestCase {
    
    private var view: MockMainStatisticsView!
    private var interactor: MockMainStatisticsInteractor!
    private var presenter: MainStatisticsPresenter!
    private var router: MockMainStatisticsRouter!
    
    override func setUpWithError() throws {
        view = MockMainStatisticsView()
        interactor = MockMainStatisticsInteractor()
        router = MockMainStatisticsRouter()
        presenter = MainStatisticsPresenter()
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        view.presenter = presenter
    }
    
    override func tearDownWithError() throws {
        view = nil
        interactor = nil
        router = nil
        presenter = nil
    }
    
    func testModuleIsNotNil() {
        
        XCTAssertNotNil(view)
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(router)
        XCTAssertNotNil(presenter)
    }
    
    func testWithCorrectMainStatisticsByCountry() {
        interactor.mainStatisticsByCountry = StatisticsModel(name: "Afghanistan", totalConfirmed: 38196, newConfirmed: 31, totalDeaths: 1406, newDeaths: 4, totalRecovered: 29231, newRecovered: 142, date: "02.09.2020", code: "AF")
        presenter.getDataByCountry()
        XCTAssertEqual(view.mainStatisticsByCountry, interactor.mainStatisticsByCountry)
        XCTAssertFalse(router.showAlert)
    }
    
    func testWithCorrectMainStatisticsByGlobal() {
        interactor.mainStatisticsByGlobal = StatisticsModel(name: "World", totalConfirmed: 25746235, newConfirmed: 264767, totalDeaths: 856969, newDeaths: 6478, totalRecovered: 17072595, newRecovered: 254664, date: "02.09.2020", code: "World")
        presenter.getDataByGlobal()
        XCTAssertEqual(view.mainStatisticsByGlobal, interactor.mainStatisticsByGlobal)
        XCTAssertFalse(router.showAlert)
    }
    
    func testWithNilMainStatisticsByCountry() {
        interactor.mainStatisticsByCountry = nil
        presenter.getDataByCountry()
        XCTAssertTrue(router.showAlert)
    }
    
    func testWithNilMainStatisticsByGlobal() {
        interactor.mainStatisticsByGlobal = nil
        presenter.getDataByGlobal()
        XCTAssertTrue(router.showAlert)
    }
    
}
