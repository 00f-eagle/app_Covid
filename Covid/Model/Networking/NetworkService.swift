//
//  NetworkService.swift
//  Covid
//
//  Created by Kirill Selivanov on 08.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class NetworkService {
    
    // MARK: - Constants
    
    private enum Urls {
        static let summary = URL(string: "https://api.covid19api.com/summary")!
        static let dayOne = URL(string: "https://api.covid19api.com/dayone/country")!
    }
    
    // MARK: - loadData
    
    func getGlobal(completionHandler: @escaping (_ model: GlobalModel?) -> ()) {
        let task = URLSession.shared.dataTask(with: Urls.summary) { data, response, error in

            if !self.checkErrors(data: data, response: response, error: error) {
                completionHandler(nil)
                return
            }
            
            do {
                let global = try JSONDecoder().decode(GlobalModel.self, from: data!)
                completionHandler(global)
            } catch {
                print("JSON error!")
            }
            
        }
        task.resume()
    }
    
    func getCountries(completionHandler: @escaping (_ model: CountriesModel?) -> ()) {
        let task = URLSession.shared.dataTask(with: Urls.summary) { data, response, error in

            if !self.checkErrors(data: data, response: response, error: error) {
                completionHandler(nil)
                return
            }
            
            do {
                let countries = try JSONDecoder().decode(CountriesModel.self, from: data!)
                completionHandler(countries)
            } catch {
                print("JSON error!")
            }
            
        }
        task.resume()
    }
    
    func getSummary(completionHandler: @escaping (_ model: SummaryModel?) -> ()) {
        let task = URLSession.shared.dataTask(with: Urls.summary) { data, response, error in

            if !self.checkErrors(data: data, response: response, error: error) {
                completionHandler(nil)
                return
            }
            
            do {
                let summary = try JSONDecoder().decode(SummaryModel.self, from: data!)
                completionHandler(summary)
            } catch {
                print("JSON error!")
            }
            
        }
        task.resume()
    }
    
    func getDayOne(country: String, completionHandler: @escaping (_ model: [DayOneModel]?) -> ()) {
        let task = URLSession.shared.dataTask(with: Urls.dayOne.appendingPathComponent("/\(country)")) { data, response, error in
           
            if !self.checkErrors(data: data, response: response, error: error) {
                completionHandler(nil)
                return
            }
            
            do {
                let dayOne = try JSONDecoder().decode([DayOneModel].self, from: data!)
                completionHandler(dayOne)
            } catch {
                print("JSON error!")
            }
            
        }
        
        task.resume()
    }
    
    // MARK: - Errors
    
    private func checkErrors(data: Data?, response: URLResponse?, error: Error?) -> Bool {
        if error != nil || data == nil {
            print("Client error!")
            return false
        }

        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            print("Server error!")
            return false
        }

        guard let mime = response.mimeType, mime == "application/json" else {
            print("Wrong MIME type!")
            return false
        }
        return true
    }
}
