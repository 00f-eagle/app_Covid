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
    func getDayOne(countryCode: String, completionHandler: @escaping (_ model: [DayOneModel]?) -> ())
}

final class NetworkService {
    
    // MARK: - Constants
    
    private enum Urls {
        static let summary = URL(string: "https://api.covid19api.com/summary")!
        static let dayOne = URL(string: "https://api.covid19api.com/total/country")!
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
                print("JSON error!")
            }
            
        }
        task.resume()
    }
    
    func getDayOne(countryCode: String, completionHandler: @escaping (_ model: [DayOneModel]?) -> ()) {
        let task = URLSession.shared.dataTask(with: Urls.dayOne.appendingPathComponent("/\(countryCode)")) { data, response, error in
           
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
