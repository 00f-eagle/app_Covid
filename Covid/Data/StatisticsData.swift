//
//  StatisticsData.swift
//  Covid
//
//  Created by Kirill Selivanov on 16.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import CoreData

protocol StatisticsDataProtocol {
    
    func addData(data: [CountryModel])
    
    func getDataByCountry(countryCode: String) -> StatisticsModel?
    
    func getDataByCountries() -> [StatisticsModel]?
    
    func searchData(text: String) -> [StatisticsModel]?
    
    func getCountryCode(country: String) -> String?
    
}

final class StatisticsData: StatisticsDataProtocol {
    
    func addData(data: [CountryModel]) {
        let fetchRequest: NSFetchRequest<Country> = Country.fetchRequest()
        
        do {
            for country in data {
                fetchRequest.predicate = NSPredicate(format: "country == %@", country.country)
                let fetchResults = try DataManager.shared.context.fetch(fetchRequest)
                if let statistic = fetchResults.first {
                    setData(statistic: statistic, country: country)
                } else {
                    let statistic = Country(context: DataManager.shared.context)
                    setData(statistic: statistic, country: country)
                }
            }
            
            DataManager.shared.saveContext()
            
        } catch {
            print("Неожиданная ошибка: \(error).")
        }
    }
    
    private func setData(statistic: Country, country: CountryModel) {
        statistic.country = country.country
        statistic.totalConfirmed = Int64(country.totalConfirmed)
        statistic.newConfirmed = Int64(country.newConfirmed)
        statistic.totalDeaths = Int64(country.totalDeaths)
        statistic.newDeaths = Int64(country.newDeaths)
        statistic.totalRecovered = Int64(country.totalRecovered)
        statistic.newRecovered = Int64(country.newRecovered)
        statistic.countryCode = country.countryCode
        statistic.date = country.convertedDate
    }
    
    func getDataByCountry(countryCode: String) -> StatisticsModel? {
        let fetchRequest: NSFetchRequest<Country> = Country.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "countryCode = %@", countryCode)
        fetchRequest.fetchLimit = 1
        do {
            let country = try DataManager.shared.context.fetch(fetchRequest).first!
            let statisticsModel = StatisticsModel(name: country.country,
                                                  totalConfirmed: Int(country.totalConfirmed),
                                                  newConfirmed: Int(country.newConfirmed),
                                                  totalDeaths: Int(country.totalDeaths),
                                                  newDeaths: Int(country.newDeaths),
                                                  totalRecovered: Int(country.totalRecovered),
                                                  newRecovered: Int(country.newRecovered),
                                                  date: country.date,
                                                  countryCode: country.countryCode)
            return statisticsModel
        } catch {
            return nil
        }
    }
    
    func getDataByCountries() -> [StatisticsModel]? {
        let fetchRequest: NSFetchRequest<Country> = Country.fetchRequest()
        do {
            let countries = try DataManager.shared.context.fetch(fetchRequest)
            
            var statistics: [StatisticsModel] = []
            for country in countries {
                let statisticsModel = StatisticsModel(name: country.country,
                                                      totalConfirmed: Int(country.totalConfirmed),
                                                      newConfirmed: Int(country.newConfirmed),
                                                      totalDeaths: Int(country.totalDeaths),
                                                      newDeaths: Int(country.newDeaths),
                                                      totalRecovered: Int(country.totalRecovered),
                                                      newRecovered: Int(country.newRecovered),
                                                      date: country.date,
                                                      countryCode: country.countryCode)
                statistics.append(statisticsModel)
            }
            return statistics
        } catch {
            return nil
        }
    }
    
    func searchData(text: String) -> [StatisticsModel]? {
        let fetchRequest: NSFetchRequest<Country> = Country.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "country BEGINSWITH[cd] %@", text)
        do {
            let countries = try DataManager.shared.context.fetch(fetchRequest)
            
            var statistics: [StatisticsModel] = []
            for country in countries {
                let statisticsModel = StatisticsModel(name: country.country,
                                                      totalConfirmed: Int(country.totalConfirmed),
                                                      newConfirmed: Int(country.newConfirmed),
                                                      totalDeaths: Int(country.totalDeaths),
                                                      newDeaths: Int(country.newDeaths),
                                                      totalRecovered: Int(country.totalRecovered),
                                                      newRecovered: Int(country.newRecovered),
                                                      date: country.date,
                                                      countryCode: country.countryCode)
                statistics.append(statisticsModel)
            }
            return statistics
        } catch {
            return nil
        }
    }
    
    func getCountryCode(country: String) -> String? {
        let fetchRequest: NSFetchRequest<Country> = Country.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "country = %@", country)
        fetchRequest.fetchLimit = 1
        do {
            return try DataManager.shared.context.fetch(fetchRequest).first?.countryCode
        } catch {
            return nil
        }
    }
}
