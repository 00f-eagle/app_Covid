//
//  PickerViewController.swift
//  Covid
//
//  Created by Kirill Selivanov on 31.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class PickerViewController: UIViewController {

    // MARK: - Constants
    
    private let identifier = "CountryCell"
    
    // MARK: - Properties
    
    let tableCountries = UITableView()
    private var cellCountry: [String?] = [] {
        didSet {
            tableCountries.reloadData()
        }
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.black
        setupView()
        loadData()
    }
    
    // MARK: - Configurations View
    
    private func setupView() {
        
        configureTableView()
        
        
        
    }
    
    private func configureTableView() {
        tableCountries.delegate = self
        tableCountries.dataSource = self
        
        tableCountries.backgroundColor = Colors.black
        tableCountries.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableCountries)
        
        NSLayoutConstraint.activate([
            tableCountries.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            tableCountries.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableCountries.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableCountries.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func loadData() {
        let statisticsData = StatisticsData()
        
        guard let countries = statisticsData.getCountries(), !countries.isEmpty else { return }
        cellCountry = countries.sorted()
    }
    

}


// MARK: - UITableViewDataSource & UITableViewDelegate
extension PickerViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellCountry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return configureCell(indexPath: indexPath)
    }
    
    private func configureCell(indexPath: IndexPath) -> UITableViewCell {
        let cell = tableCountries.dequeueReusableCell(withIdentifier: identifier)
            ?? UITableViewCell(style: .default, reuseIdentifier: identifier)
        cell.backgroundColor = Colors.black
        let item = cellCountry[indexPath.row]
        cell.textLabel?.text = item
        cell.textLabel?.textColor = Colors.white
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //presenter.presentCity(city: cities[indexPath.row])
    }
}
