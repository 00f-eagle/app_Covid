//
//  UserData.swift
//  Covid
//
//  Created by Kirill Selivanov on 04.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import CoreData

protocol UserDataProtocol {
    
    func addCountryCode(countryCode: String)
    
    func getCountryCode() -> String?

}

final class UserData: UserDataProtocol {
    
    func addCountryCode(countryCode: String) {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let fetchResults = try DataManager.shared.context.fetch(fetchRequest)
            if let user = fetchResults.first {
                user.countryCode = countryCode
            } else {
                let user = User(context: DataManager.shared.context)
                user.countryCode = countryCode
            }
            DataManager.shared.saveContext()
        } catch {
            print("Неожиданная ошибка: \(error).")
        }
    }
    
    func getCountryCode() -> String? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            return try DataManager.shared.context.fetch(fetchRequest).first?.countryCode
        } catch {
            return nil
        }
    }
}
