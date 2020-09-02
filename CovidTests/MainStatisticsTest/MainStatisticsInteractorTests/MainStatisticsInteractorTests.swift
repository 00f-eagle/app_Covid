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
        interactor = MainStatisticsInteractor(covidFacade: covidFacade, userStorage: userStorage)
        presenter = MockMainStatisticsInteractorOutput()
    }

    override func tearDownWithError() throws {
        interactor = nil
        presenter = nil
        covidFacade = nil
        userStorage = nil
    }
    
    func testOne() {
        interactor.loadStatisticsByCountry()
    }
    
}
