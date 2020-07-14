//
//  CountriesViewController.swift
//  Covid
//
//  Created by Kirill Selivanov on 08.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class CountriesViewController: UIViewController {

    // MARK: - Constants
    
    private let identifier = "CountryCell"
    private let rowHeight = CGFloat(50)
    
    // MARK: - Properties
    
    private let tableCountries = UITableView()
    private var cellCountry: [CountryCellModel] = [] {
        didSet {
            tableCountries.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ns = NetworkService()
        ns.getCountries { (response) in
            DispatchQueue.main.async {
                if let countriesModel = response?.countries.sorted(by: { $0.totalConfirmed > $1.totalConfirmed}) {
                    for country in countriesModel {
                        self.cellCountry.append(CountryCellModel(country: country.country, totalStatus: country.totalConfirmed, newStatus: country.newConfirmed))
                    }
                }
            }
        }
        
        view.backgroundColor = .white
        
        tableCountries.dataSource = self
        tableCountries.delegate = self
        tableCountries.register(CountryCell.self, forCellReuseIdentifier: identifier)
        
        tableCountries.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableCountries)
        
        NSLayoutConstraint.activate([
            tableCountries.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableCountries.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableCountries.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
        
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                tableCountries.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                tableCountries.topAnchor.constraint(equalTo: view.topAnchor)
            ])
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
   
extension CountriesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellCountry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? CountryCell {
            cell.countryModel = cellCountry[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
}
