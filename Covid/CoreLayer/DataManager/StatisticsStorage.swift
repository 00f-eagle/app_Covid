//
//  StatisticsStorage.swift
//  Covid
//
//  Created by Kirill Selivanov on 24.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import CoreData

protocol StatisticsStorageProtocol {
    
    func addCountries(countries: [CountryModel])
    
    func getCountry(countryCode: String) -> StatisticsModel?
    
    func getCountries(searchText: String) -> [StatisticsModel]?
    
    func addGlobal(data: GlobalModel, date: String)
    
    func getGlobal() -> StatisticsModel?
    
    func addLastDays(countryCode: String, data: [DayModel])
    
    func getLastDays(countryCode: String) -> [DayModel]?
    
}

final class StatisticsStorage: StatisticsStorageProtocol {
    
    func addCountries(countries: [CountryModel]) {
        let fetchRequest: NSFetchRequest<CountryEntity> = CountryEntity.fetchRequest()
        fetchRequest.fetchLimit = 1
        do {
            try countries.forEach { country in
                fetchRequest.predicate = NSPredicate(format: "name == %@", country.name)
                let fetchResults = try CoreDataManager.shared.context.fetch(fetchRequest)
                let statistics = fetchResults.first ?? CountryEntity(context: CoreDataManager.shared.context)
                statistics.name = country.name
                statistics.totalConfirmed = Int64(country.totalConfirmed)
                statistics.newConfirmed = Int64(country.newConfirmed)
                statistics.totalDeaths = Int64(country.totalDeaths)
                statistics.newDeaths = Int64(country.newDeaths)
                statistics.totalRecovered = Int64(country.totalRecovered)
                statistics.newRecovered = Int64(country.newRecovered)
                statistics.code = country.code
                statistics.date = country.convertedDate
            }
            CoreDataManager.shared.saveContext()
        }
        catch _ as NSError {}
    }
    
    func getCountry(countryCode: String) -> StatisticsModel? {
        let fetchRequest: NSFetchRequest<CountryEntity> = CountryEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "code = %@", countryCode)
        fetchRequest.fetchLimit = 1
        do {
            guard let country = try CoreDataManager.shared.context.fetch(fetchRequest).first else { return nil }
            let statisticsModel = StatisticsModel(name: country.name, totalConfirmed: Int(country.totalConfirmed), newConfirmed: Int(country.newConfirmed), totalDeaths: Int(country.totalDeaths), newDeaths: Int(country.newDeaths), totalRecovered: Int(country.totalRecovered), newRecovered: Int(country.newRecovered), date: country.date, code: country.code)
            return statisticsModel
        } catch {
            return nil
        }
    }
    
    func getCountries(searchText: String) -> [StatisticsModel]? {
        let fetchRequest: NSFetchRequest<CountryEntity> = CountryEntity.fetchRequest()
        if !searchText.isEmpty {
            fetchRequest.predicate = NSPredicate(format: "name BEGINSWITH[cd] %@", searchText)
        }
        do {
            let countries = try CoreDataManager.shared.context.fetch(fetchRequest)
            var statistics: [StatisticsModel] = []
            countries.forEach { country in
                let statisticsModel = StatisticsModel(name: country.name, totalConfirmed: Int(country.totalConfirmed), newConfirmed: Int(country.newConfirmed), totalDeaths: Int(country.totalDeaths), newDeaths: Int(country.newDeaths), totalRecovered: Int(country.totalRecovered), newRecovered: Int(country.newRecovered), date: country.date, code: country.code)
                statistics.append(statisticsModel)
            }
            return statistics
        } catch {
            return nil
        }
    }
    
    func addGlobal(data: GlobalModel, date: String) {
        let fetchRequest: NSFetchRequest<GlobalEntity> = GlobalEntity.fetchRequest()
        do {
            let fetchResults = try CoreDataManager.shared.context.fetch(fetchRequest)
            let global = fetchResults.first ?? GlobalEntity(context: CoreDataManager.shared.context)
            global.name = data.name
            global.totalConfirmed = Int64(data.totalConfirmed)
            global.totalDeaths = Int64(data.totalDeaths)
            global.totalRecovered = Int64(data.totalRecovered)
            global.newConfirmed = Int64(data.newConfirmed)
            global.newDeaths = Int64(data.newDeaths)
            global.newRecovered = Int64(data.newRecovered)
            global.code = data.code
            global.date = date
            CoreDataManager.shared.saveContext()
        }
        catch _ as NSError {}
    }
    
    func getGlobal() -> StatisticsModel? {
        let fetchRequest: NSFetchRequest<GlobalEntity> = GlobalEntity.fetchRequest()
        do {
            guard let global = try CoreDataManager.shared.context.fetch(fetchRequest).first else { return nil }
            let statisticsModel = StatisticsModel(name: global.name, totalConfirmed: Int(global.totalConfirmed), newConfirmed: Int(global.newConfirmed), totalDeaths: Int(global.totalDeaths), newDeaths: Int(global.newDeaths), totalRecovered: Int(global.totalRecovered), newRecovered: Int(global.newRecovered), date: global.date, code: global.code)
            return statisticsModel
        } catch {
            return nil
        }
    }
    
    func addLastDays(countryCode: String, data: [DayModel]) {
        let fetchRequest: NSFetchRequest<LastDayEntity> = LastDayEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "code = %@", countryCode)
        do {
            
            let lastDays = try CoreDataManager.shared.context.fetch(fetchRequest)
            
            lastDays.forEach({ lastDay in
                CoreDataManager.shared.context.delete(lastDay)
            })
            
            data.forEach { day in
                let lastDay = LastDayEntity(context: CoreDataManager.shared.context)
                lastDay.code = countryCode
                lastDay.confirmed = Int64(day.confirmed)
                lastDay.deaths = Int64(day.deaths)
                lastDay.recovered = Int64(day.recovered)
                lastDay.date = day.date
            }
            
            CoreDataManager.shared.saveContext()
        }
        catch _ as NSError {}
    }
    
    func getLastDays(countryCode: String) -> [DayModel]? {
        let fetchRequest: NSFetchRequest<LastDayEntity> = LastDayEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "code = %@", countryCode)
        do {
            let lastDays = try CoreDataManager.shared.context.fetch(fetchRequest)
            guard !lastDays.isEmpty else { return nil }
            var allDays: [DayModel] = []
            lastDays.forEach { lastDay in
                allDays.append(DayModel(confirmed: Int(lastDay.confirmed), deaths: Int(lastDay.deaths), recovered: Int(lastDay.recovered), date: lastDay.date))
            }
            return allDays
        } catch {
            return nil
        }
    }
}
