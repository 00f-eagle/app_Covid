//
//  UserData.swift
//  Covid
//
//  Created by Kirill Selivanov on 04.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import CoreData

final class UserData: UserDataProtocol {
    
    func addData(country: String) {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let fetchResults = try DataManager.shared.context.fetch(fetchRequest)
            let user: User
            if !fetchResults.isEmpty {
                user = fetchResults.first!
            } else {
                user = User(context: DataManager.shared.context)
            }
            user.country = country
            DataManager.shared.saveContext()
        } catch {
            print("Неожиданная ошибка: \(error).")
        }
    }
    
    func getData() -> String? {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            return try DataManager.shared.context.fetch(fetchRequest).first?.country
        } catch {
            return nil
        }
    }
}
