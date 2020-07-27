//
//  StatisticsViewController.swift
//  Covid
//
//  Created by Kirill Selivanov on 30.06.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class StatisticsViewController: UIViewController {
    
    // MARK: - Properties
    
    var presenter: StatisticsViewOutput!
    
    private let contentView = UIView()
    private let scrollView = UIScrollView()
    private let countryStatisticsView = StatisticsView()
    private let globalStatisticsView = StatisticsView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.black
        
        setupView()
        presenter.getData()
    }
    
    // MARK: - Configurations View
    
    private func setupView() {

        configureScrollView()
        configureContentView()
        
        let countryStackView = countryStatisticsView.configureStatisticsStackView()
        let globalStackView = globalStatisticsView.configureStatisticsStackView()
        addGestureByCountryStackView()
        contentView.addSubview(countryStackView)
        contentView.addSubview(globalStackView)
        
        NSLayoutConstraint.activate([
            countryStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            countryStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            globalStackView.topAnchor.constraint(equalTo: countryStackView.bottomAnchor, constant: 25),
            globalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            globalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func configureContentView() {
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        if #available(iOS 11.0, *) {
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        }
    }
    
    private func addGestureByCountryStackView() {
        countryStatisticsView.titleLabel.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapChangeCountry))
        countryStatisticsView.titleLabel.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - Active
    
    @objc private func tapChangeCountry() {
        presenter.changeCountry()
    }
}


// MARK: - StatisticsViewInput
extension StatisticsViewController: StatisticsViewInput {
    
    func succes(global: Statistics, country: Statistics) {
        
        countryStatisticsView.titleLabel.text = country.country
        countryStatisticsView.numberConfirmedLabel.text = "\(Int(country.confirmed).formattedWithSeparator)"
        countryStatisticsView.numberDeathsLabel.text = "\(Int(country.deaths).formattedWithSeparator)"
        countryStatisticsView.numberRecoveredLabel.text = "\(Int(country.recovered).formattedWithSeparator)"
        countryStatisticsView.incConfirmedLabel.text = "+\(Int(country.incConfirmed).formattedWithSeparator)"
        countryStatisticsView.incDeathsLabel.text = "+\(Int(country.incDeaths).formattedWithSeparator)"
        countryStatisticsView.incRecoveredLabel.text = "+\(Int(country.incRecoverded).formattedWithSeparator)"
        
        globalStatisticsView.titleLabel.text = global.country
        globalStatisticsView.numberConfirmedLabel.text = "\(Int(global.confirmed).formattedWithSeparator)"
        globalStatisticsView.numberDeathsLabel.text = "\(Int(global.deaths).formattedWithSeparator)"
        globalStatisticsView.numberRecoveredLabel.text = "\(Int(global.recovered).formattedWithSeparator)"
        globalStatisticsView.incConfirmedLabel.text = "+\(Int(global.incConfirmed).formattedWithSeparator)"
        globalStatisticsView.incDeathsLabel.text = "+\(Int(global.incDeaths).formattedWithSeparator)"
        globalStatisticsView.incRecoveredLabel.text = "+\(Int(global.incRecoverded).formattedWithSeparator)"
    }
    
    func failure() {
        presenter.presentFailureAlert(title: "Ошибка", message: "Не удалось получить данные")
    }
}
