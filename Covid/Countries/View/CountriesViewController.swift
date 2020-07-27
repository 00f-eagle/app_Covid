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
    
    // MARK: - Properties
    
    var presenter: CountriesViewOutput!
    
    private var status: Status?
    
    private let confirmedButton = UIButton()
    private let deathsButton = UIButton()
    private let recoveredButton = UIButton()
    
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
        tapConfirmedButton()
    }
    
    // MARK: - Configurations
    
    private func setupView() {
        
        configureButton(button: confirmedButton, text: Texts.confirmed, color: Colors.orange, tap: #selector(tapConfirmedButton))
        configureButton(button: deathsButton, text: Texts.deaths, color: Colors.red, tap: #selector(tapDeathsButton))
        configureButton(button: recoveredButton, text: Texts.recovered, color: Colors.green, tap: #selector(tapRecoveredButton))
        
        configureHeaderStackView()
        configureTableView()
        
        NSLayoutConstraint.activate([
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            tableCountries.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableCountries.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableCountries.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        if #available(iOS 11.0, *) {
            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            tableCountries.topAnchor.constraint(equalTo: headerStackView.safeAreaLayoutGuide.bottomAnchor, constant: 5).isActive = true
        } else {
            headerStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
            tableCountries.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 5).isActive = true
        }
    }
    
    private func configureButton(button: UIButton, text: String, color: UIColor, tap: Selector) {
        button.layer.cornerRadius = 3
        button.layer.borderWidth = 1
        button.backgroundColor = color
        button.setTitle(text, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
        button.addTarget(self, action: tap, for: .touchUpInside)
    }
    
    private func configureHeaderStackView() {
        let countrySearchBar = configureSearchBar()
        let statusButtonStackView = setupStatusButtonStackView()
        headerStackView.addArrangedSubview(countrySearchBar)
        headerStackView.addArrangedSubview(statusButtonStackView)
        headerStackView.axis = .vertical
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerStackView)
    }
    
    private func setupStatusButtonStackView() -> UIStackView{
        let stack = UIStackView()
        stack.addArrangedSubview(confirmedButton)
        stack.addArrangedSubview(deathsButton)
        stack.addArrangedSubview(recoveredButton)
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        return stack
    }
    
    private func configureSearchBar() -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.barTintColor = Colors.black
        searchBar.placeholder = "Поиск страны"
        let textField = searchBar.value(forKey: "searchField") as? UITextField
        textField?.textColor = Colors.white
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
    
    private func changeButton(buttonOne: UIButton, buttonTwo: UIButton, buttonThree: UIButton) {
        buttonOne.titleLabel?.font = .systemFont(ofSize: 15, weight: .heavy)
        buttonTwo.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
        buttonThree.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
    }
    
    // MARK: - Active
    
    @objc private func tapConfirmedButton() {
        status = Status.confirmed
        changeButton(buttonOne: confirmedButton, buttonTwo: deathsButton, buttonThree: recoveredButton)
        presenter.loadData(status: status!)
    }
    
    @objc private func tapDeathsButton() {
        status = Status.deaths
        changeButton(buttonOne: deathsButton, buttonTwo: confirmedButton, buttonThree: recoveredButton)
        presenter.loadData(status: status!)
    }
    
    @objc private func tapRecoveredButton() {
        status = Status.recoverded
        changeButton(buttonOne: recoveredButton, buttonTwo: confirmedButton, buttonThree: deathsButton)
        presenter.loadData(status: status!)
    }
}


// MARK: - UITableViewDataSource & UITableViewDelegate
extension CountriesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellCountry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? CountryCell {
            let countryModel = cellCountry[indexPath.row]
            cell.updateContent(countryModel: countryModel, status: status!)
            return cell
        }
        return UITableViewCell()
    }
}


// MARK: - UISearchBarDelegate
extension CountriesViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchCountry(text: searchBar.text!, status: status!)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.loadData(status: status!)
        searchBar.text = nil
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchCountry(text: searchText, status: status!)
    }
}


// MARK: - StatisticsViewInput
extension CountriesViewController: CountriesViewInput {
    func succes(countries: [Statistics]) {
        cellCountry = countries
    }
    
    func failure() {
        presenter.presentFailureAlert(title: "Ошибка", message: "Не удалось получить данные")
    }
}
