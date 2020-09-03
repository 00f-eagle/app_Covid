//
//  MockUserStorage.swift
//  CovidTests
//
//  Created by Kirill Selivanov on 02.09.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

@testable import Covid

final class MockUserStorage: UserStorageProtocol {
    
    var countryCode: String?
    
    func addCountryCode(countryCode: String) {
        self.countryCode = countryCode
    }
    
    func getCountryCode() -> String? {
        return countryCode
    }
}
