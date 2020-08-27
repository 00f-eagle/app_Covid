//
//  NetworkService.swift
//  Covid
//
//  Created by Kirill Selivanov on 08.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//
import UIKit

protocol NetworkServiceProtocol {
    
    func getSummary(completionHandler: @escaping (_ model: SummaryModel?) -> ())
    func getAllDays(countryCode: String, completionHandler: @escaping (_ model: [DayModel]?) -> ())
}

final class NetworkService {
    
    // MARK: - Constants
    
    private enum Urls {
        static let summary = URL(string: "https://api.covid19api.com/summary")!
        static let allDaysByCountry = URL(string: "https://api.covid19api.com/total/country")!
    }
    
}

// MARK: - NetworkServiceProtocol
extension NetworkService: NetworkServiceProtocol {
    func getSummary(completionHandler: @escaping (_ model: SummaryModel?) -> ()) {
        let task = URLSession.shared.dataTask(with: Urls.summary) { data, response, error in

            if !self.checkErrors(data: data, response: response, error: error) {
                completionHandler(nil)
                return
            }
            
            do {
                let summaryModel = try JSONDecoder().decode(SummaryModel.self, from: data!)
                completionHandler(summaryModel)
            } catch {
                completionHandler(nil)
            }
        }
        
        task.resume()
    }
    
    func getAllDays(countryCode: String, completionHandler: @escaping (_ model: [DayModel]?) -> ()) {
        let task = URLSession.shared.dataTask(with: Urls.allDaysByCountry.appendingPathComponent("/\(countryCode)")) { data, response, error in
           
            if !self.checkErrors(data: data, response: response, error: error) {
                completionHandler(nil)
                return
            }
            
            do {
                let allDays = try JSONDecoder().decode([DayModel].self, from: data!)
                completionHandler(allDays)
            } catch {
                completionHandler(nil)
            }
        }
        
        task.resume()
    }
    
    // MARK: - Errors
    
    private func checkErrors(data: Data?, response: URLResponse?, error: Error?) -> Bool {
        if error != nil || data == nil {
            return false
        }

        guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
            return false
        }

        guard let mime = response.mimeType, mime == "application/json" else {
            return false
        }
        return true
    }
}
