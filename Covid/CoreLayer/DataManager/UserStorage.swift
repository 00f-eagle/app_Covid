//
//  UserStorage.swift
//  Covid
//
//  Created by Kirill Selivanov on 26.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import CoreData

protocol UserStorageProtocol {
    
    func addCountryCode(countryCode: String)
    
    func getCountryCode() -> String?
}

final class UserStorage: UserStorageProtocol {
    
    func addCountryCode(countryCode: String) {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        do {
            let fetchResults = try CoreDataManager.shared.context.fetch(fetchRequest)
            let user = fetchResults.first ?? UserEntity(context: CoreDataManager.shared.context)
            user.countryCode = countryCode
            CoreDataManager.shared.saveContext()
        }
        catch _ as NSError {}
    }
    
    func getCountryCode() -> String? {
        let fetchRequest: NSFetchRequest<UserEntity> = UserEntity.fetchRequest()
        do {
            guard let firstData = try CoreDataManager.shared.context.fetch(fetchRequest).first else { return nil }
            return firstData.countryCode
        } catch {
            return nil
        }
    }
}
