//
//  StatisticsPresenter.swift
//  Covid
//
//  Created by Kirill Selivanov on 14.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

protocol StatisticsViewProtocol {
    func succes()
    func failure()
}

protocol StatisticsPresenterProtocol {
    init(view: StatisticsViewProtocol)
    func getData()
    
    var numberCountryConfirmed: String? { get set }
    var numberCountryDeaths: String? { get set }
    var numberCountryRecovered: String? { get set }
    var incCountryConfirmed: String? { get set }
    var incCountryDeaths: String? { get set }
    var incCountryRecovered: String? { get set }
    
    var numberGlobalConfirmed: String? { get set }
    var numberGlobalDeaths: String? { get set }
    var numberGlobalRecovered: String? { get set }
    var incGlobalConfirmed: String? { get set }
    var incGlobalDeaths: String? { get set }
    var incGlobalRecovered: String? { get set }

}

final class StatisticsPresenter: StatisticsPresenterProtocol {
    var numberCountryConfirmed: String?
    var numberCountryDeaths: String?
    var numberCountryRecovered: String?
    var incCountryConfirmed: String?
    var incCountryDeaths: String?
    var incCountryRecovered: String?
    
    var numberGlobalConfirmed: String?
    var numberGlobalDeaths: String?
    var numberGlobalRecovered: String?
    var incGlobalConfirmed: String?
    var incGlobalDeaths: String?
    var incGlobalRecovered: String?
    
    let view: StatisticsViewProtocol
    
    init(view: StatisticsViewProtocol) {
        self.view = view
    }
    
    func getData() {
        let ns = NetworkService()
        ns.getGlobal { (response) in
            DispatchQueue.main.async {
                if let globalModel = response {
                    self.numberGlobalConfirmed = self.addSpacing(string: String(globalModel.global.totalConfirmed))
                    self.numberGlobalDeaths = self.addSpacing(string:String(globalModel.global.totalDeaths))
                    self.numberGlobalRecovered = self.addSpacing(string:String(globalModel.global.totalRecovered))
                    self.incGlobalConfirmed = "+\(self.addSpacing(string:(String(globalModel.global.newConfirmed))))"
                    self.incGlobalDeaths = "+\(self.addSpacing(string:String(globalModel.global.newDeaths)))"
                    self.incGlobalRecovered = "+\(self.addSpacing(string:(String(globalModel.global.newRecovered))))"
                    self.view.succes()
                } else {
                    self.view.failure()
                }
            }
        }
        ns.getCountries { (response) in
            DispatchQueue.main.async {
                if let countriesModel = response?.countries.filter({ (Countries) -> Bool in
                    Countries.countryCode == "RU"
                }) {
                    self.numberCountryConfirmed = self.addSpacing(string: String(countriesModel[0].totalConfirmed))
                    self.numberCountryDeaths = self.addSpacing(string: String(countriesModel[0].totalDeaths))
                    self.numberCountryRecovered = self.addSpacing(string: String(countriesModel[0].totalRecovered))
                    self.incCountryConfirmed = "+\(self.addSpacing(string: String(countriesModel[0].newConfirmed)))"
                    self.incCountryDeaths = "+\(self.addSpacing(string: String(countriesModel[0].newDeaths)))"
                    self.incCountryRecovered = "+\(self.addSpacing(string: String(countriesModel[0].newRecovered)))"
                    self.view.succes()
                } else {
                    self.view.failure()
                }
            }
        }
    }
    
    private func addSpacing(string: String) -> String{
        var mainString = ""
        var count = 0
        for char in String(string.reversed()) {
            mainString.append(char)
            count += 1
            if count % 3 == 0 && count != string.count {
                mainString.append(" ")
            }
            
        }
        return String(mainString.reversed())
    }
    
}
