//
//  StatisticsData.swift
//  Covid
//
//  Created by Kirill Selivanov on 16.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

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
                    statistic = fetchResults.first!
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
                statistic.slug = country.slug
            }
            
            DataManager.shared.saveContext()
            
        } catch {
            print("Неожиданная ошибка: \(error).")
        }
    }
    
    func getDataByCountry(country: String) -> Statistics? {
        let fetchRequest: NSFetchRequest<Statistics> = Statistics.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "country = %@", country)
        fetchRequest.fetchLimit = 1
        do {
            return try DataManager.shared.context.fetch(fetchRequest).first
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
        fetchRequest.predicate = NSPredicate(format: "country != %@ && country BEGINSWITH[cd] %@", "World", text)
        do {
            return try DataManager.shared.context.fetch(fetchRequest)
        } catch {
            return nil
        }
    }
    
    func getCountries() -> [String]? {
        let fetchRequest: NSFetchRequest<Statistics> = Statistics.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "country != %@", "World")
        do {
            var countries: [String] = []
            try DataManager.shared.context.fetch(fetchRequest).forEach( { countries.append($0.country) })
            return countries
        } catch {
            return nil
        }
    }
    
    func getSlug(country: String) -> String? {
        let fetchRequest: NSFetchRequest<Statistics> = Statistics.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "country = %@", country)
        fetchRequest.fetchLimit = 1
        do {
            return try DataManager.shared.context.fetch(fetchRequest).first?.slug
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
            print("Неожиданная ошибка: \(error).")
        }
    }
}
