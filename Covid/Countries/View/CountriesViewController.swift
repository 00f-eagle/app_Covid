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
    
    enum Constants {
        static let identifier = "CountryCell"
        static let items = [Texts.confirmed, Texts.deaths, Texts.recovered]
        static let heightRow: CGFloat = 60
    }
    
    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var presenter: CountriesViewOutput!
    
    private var status = Status.confirmed
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
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.loadData(text: searchText, status: status)
    }
    
    // MARK: - Configurations
    
    private func setupView() {
        view.backgroundColor = Colors.black
        configureHeaderStackView()
        configureTableView()
        
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                tableCountries.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableCountries.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableCountries.topAnchor.constraint(equalTo: headerStackView.safeAreaLayoutGuide.bottomAnchor, constant: 5),
                tableCountries.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        } else {
            NSLayoutConstraint.activate([
                headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                headerStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
                tableCountries.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableCountries.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                tableCountries.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 5),
                tableCountries.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -49)
            ])
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
        let segmentedControl = UISegmentedControl(items: Constants.items)
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
        tableCountries.register(CountryCell.self, forCellReuseIdentifier: Constants.identifier)
        tableCountries.backgroundColor = Colors.black
        tableCountries.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableCountries)
    }
    
    // MARK: - Active
    
    @objc private func selectedStatus(_ segmentedControl: UISegmentedControl) {
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            status = Status.confirmed
            presenter.loadData(text: searchText, status: status)
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.identifier, for: indexPath) as? CountryCell else {
            return UITableViewCell()
        }
        
        let countryModel = cellCountry[indexPath.row]
        cell.updateContent(countryModel: countryModel, status: status)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.showCountry(country: cellCountry[indexPath.row].country)
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightRow
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
