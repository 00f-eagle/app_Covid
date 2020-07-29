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
    private let items = [Texts.confirmed, Texts.deaths, Texts.recovered]
    
    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var presenter: CountriesViewOutput!
    
    private var status: Status!
    private var searchText = ""
    
    private let headerStackView = UIStackView()
    
    private let tableCountries = UITableView()
    private var cellCountry: [Statistics] = [] {
        didSet {
            tableCountries.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.black
        
        setupView()
        
        status = Status.confirmed
        presenter.loadData(text: searchText, status: status)
    }
    
    // MARK: - Configurations
    
    private func setupView() {
        
        configureHeaderStackView()
        configureTableView()
        
        NSLayoutConstraint.activate([
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableCountries.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableCountries.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
        ])
        
        if #available(iOS 11.0, *) {
            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            tableCountries.topAnchor.constraint(equalTo: headerStackView.safeAreaLayoutGuide.bottomAnchor, constant: 5).isActive = true
            tableCountries.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            headerStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
            tableCountries.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 5).isActive = true
            tableCountries.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -49).isActive = true
        }
    }
    
    private func configureHeaderStackView() {
        
        let statusSegmentedControl = configureSegmentedControl()
        let countrySearchBar = configureSearchBar()
        headerStackView.addArrangedSubview(countrySearchBar)
        headerStackView.addArrangedSubview(statusSegmentedControl)
        headerStackView.axis = .vertical
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerStackView)
    }
    
    private func configureSegmentedControl() -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(self, action: #selector(selectedStatus), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.black], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: Colors.white], for: .normal)
        return segmentedControl
    }
    
    private func configureSearchBar() -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.barTintColor = Colors.black
        searchBar.placeholder = "Поиск страны"
        searchBar.returnKeyType = .done
        searchBar.enablesReturnKeyAutomatically = false
        if #available(iOS 11.0, *) {
            let textField = searchBar.value(forKey: "searchField") as? UITextField
            textField?.textColor = Colors.white
        }
        return searchBar
    }
    
    private func configureTableView() {
        tableCountries.dataSource = self
        tableCountries.delegate = self
        tableCountries.register(CountryCell.self, forCellReuseIdentifier: identifier)
        
        tableCountries.backgroundColor = Colors.black
        tableCountries.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableCountries)
    }
    
    // MARK: - Active
    
    @objc private func selectedStatus(_ segmentedControl: UISegmentedControl) {
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            status = Status.confirmed
            presenter.loadData(text: searchText, status: Status.confirmed)
        case 1:
            status = Status.deaths
            presenter.loadData(text: searchText, status: status)
        case 2:
            status = Status.recoverded
            presenter.loadData(text: searchText, status: status)
        default:
            break
        }
    }
}


// MARK: - UITableViewDataSource & UITableViewDelegate
extension CountriesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellCountry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? CountryCell, let status = status else {
            return UITableViewCell()
        }
        
        let countryModel = cellCountry[indexPath.row]
        cell.updateContent(countryModel: countryModel, status: status)
        return cell
    }
}


// MARK: - UISearchBarDelegate
extension CountriesViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        presenter.loadData(text: searchText, status: status)
    }
}


// MARK: - StatisticsViewInput
extension CountriesViewController: CountriesViewInput {
    func success(countries: [Statistics]) {
        cellCountry = countries
    }
    
    func failure() {
        presenter.presentFailureAlert(title: "Ошибка", message: "Не удалось получить данные")
    }
}
