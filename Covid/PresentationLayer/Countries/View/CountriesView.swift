//
//  CountriesView.swift
//  Covid
//
//  Created by Kirill Selivanov on 08.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class CountriesView: UIViewController {
    
    // MARK: - Constants
    
    private enum Locals {
        static let identifier = "CountryCell"
        static let items = [Texts.confirmed, Texts.deaths, Texts.recovered]
        static let heightRow: CGFloat = 60
    }
    
    // MARK: - Properties
    
    var presenter: CountriesViewOutput!
    
    private var status = Status.confirmed
    private var searchText = ""
    
    private let headerStackView = UIStackView()
    
    private let tableCountries = UITableView()
    private var cellCountry: [StatisticsOfStatusModel] = [] {
        didSet {
            tableCountries.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getCountries(searchText: searchText, status: status)
    }
    
    // MARK: - Configurations
    
    private func setupView() {
        view.backgroundColor = Colors.white
        configureHeaderStackView()
        configureTableView()
    }
    
    private func configureHeaderStackView() {
        let statusSegmentedControl = createSegmentedControl()
        let countrySearchBar = createSearchBar()
        headerStackView.addArrangedSubview(countrySearchBar)
        headerStackView.addArrangedSubview(statusSegmentedControl)
        headerStackView.axis = .vertical
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerStackView)
        
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.leading),
                headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.trailing)
            ])
        } else {
            NSLayoutConstraint.activate([
                headerStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: Margin.safeAreaTop),
                headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.leading),
                headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.trailing)
            ])
        }
    }
    
    private func createSegmentedControl() -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: Locals.items)
        segmentedControl.addTarget(self, action: #selector(selectedStatus), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }
    
    private func createSearchBar() -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "Поиск страны"
        searchBar.returnKeyType = .done
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.backgroundImage = UIImage()
        let textField = searchBar.value(forKey: "searchField") as? UITextField
        textField?.backgroundColor = Colors.gray
        return searchBar
    }
    
    private func configureTableView() {
        tableCountries.dataSource = self
        tableCountries.delegate = self
        tableCountries.register(CountryCell.self, forCellReuseIdentifier: Locals.identifier)
        tableCountries.backgroundColor = Colors.gray
        tableCountries.layer.cornerRadius = Margin.cornerRadius
        tableCountries.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableCountries)
        
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                tableCountries.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.leading),
                tableCountries.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.trailing),
                tableCountries.topAnchor.constraint(equalTo: headerStackView.safeAreaLayoutGuide.bottomAnchor, constant: Margin.top),
                tableCountries.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Margin.bottom)
            ])
        } else {
            NSLayoutConstraint.activate([
                tableCountries.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.leading),
                tableCountries.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.trailing),
                tableCountries.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 5),
                tableCountries.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Margin.heightOfTabBar + Margin.bottom)
            ])
        }
    }
    
    // MARK: - Active
    
    @objc private func selectedStatus(_ segmentedControl: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            status = Status.confirmed
            presenter.getCountries(searchText: searchText, status: status)
        case 1:
            status = Status.deaths
            presenter.getCountries(searchText: searchText, status: status)
        case 2:
            status = Status.recoverded
            presenter.getCountries(searchText: searchText, status: status)
        default:
            break
        }
    }
}


// MARK: - UITableViewDataSource & UITableViewDelegate
extension CountriesView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellCountry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Locals.identifier, for: indexPath) as? CountryCell else {
            return UITableViewCell()
        }
        
        let countryModel = cellCountry[indexPath.row]
        cell.statisticsOfStatus = countryModel
        cell.status = status
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showCountry(countryCode: cellCountry[indexPath.row].code)
    }
}


// MARK: - UISearchBarDelegate
extension CountriesView: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
        presenter.getCountries(searchText: searchText, status: status)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Locals.heightRow
    }
}


// MARK: - StatisticsViewInput
extension CountriesView: CountriesViewInput {
    func presentCountries(countries: [StatisticsOfStatusModel]) {
        cellCountry = countries
    }
}
