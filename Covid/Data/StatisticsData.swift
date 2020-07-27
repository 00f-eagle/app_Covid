//
//  StatisticsData.swift
//  Covid
//
//  Created by Kirill Selivanov on 16.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit
import CoreData

final class StatisticsData: StatisticsDataProtocol {
    
    func addData(data: [CountryModel]) {
        let fetchRequest: NSFetchRequest<Statistics> = Statistics.fetchRequest()
        
        do {
            for country in data {
                fetchRequest.predicate = NSPredicate(format: "country == %@", country.country)
                let fetchResults = try DataManager.shared.context.fetch(fetchRequest)
                let statistic: Statistics
                if !fetchResults.isEmpty {
                    statistic = fetchResults[0]
                } else {
                    statistic = Statistics(context: DataManager.shared.context)
                }
                
                statistic.country = country.country
                statistic.confirmed = Int64(country.totalConfirmed)
                statistic.incConfirmed = Int64(country.newConfirmed)
                statistic.deaths = Int64(country.totalDeaths)
                statistic.incDeaths = Int64(country.newDeaths)
                statistic.recovered = Int64(country.totalRecovered)
                statistic.incRecoverded = Int64(country.newRecovered)
            }
            
            DataManager.shared.saveContext()
            
        } catch {
            print("Error addData")
        }
    }
    
    func getDataByCountry(country: String) -> Statistics? {
        let fetchRequest: NSFetchRequest<Statistics> = Statistics.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "country = %@", country)
        do {
            return try DataManager.shared.context.fetch(fetchRequest)[0]
        } catch {
            return nil
        }
    }
    
    func getDataByCountries() -> [Statistics]? {
        let fetchRequest: NSFetchRequest<Statistics> = Statistics.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "country != %@", "World")
        do {
            return try DataManager.shared.context.fetch(fetchRequest)
        } catch {
            return nil
        }
    }
    
    func searchData(text: String) -> [Statistics]? {
        let fetchRequest: NSFetchRequest<Statistics> = Statistics.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "country BEGINSWITH[c] %@", text)
        do {
            return try DataManager.shared.context.fetch(fetchRequest)
        } catch {
            return nil
        }
    }
    
    func removeAll() {
        let fetchRequest: NSFetchRequest<Statistics> = Statistics.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        do {
            try DataManager.shared.context.execute(deleteRequest)
            DataManager.shared.saveContext()
        } catch {
            print("Error removeAll")
        }
    }
}
