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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var presenter: StatisticsViewOutput!
    
    private let indicator = UIActivityIndicatorView()
    private let countryStatisticsStackView = StatisticsStackView()
    private let globalStatisticsStackView = StatisticsStackView()
    private let scrollView = UIScrollView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.black
        
        setupView()
        presenter.getData()
    }
    
    // MARK: - Configurations View
    
    private func setupView() {
        
        activityIndicator()
        configureScrollView()
        
        
        addGestureByCountryStackView()
        countryStatisticsStackView.titleLabel.text = "RU"
        globalStatisticsStackView.titleLabel.text = "World"
        
        NSLayoutConstraint.activate([
            countryStatisticsStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            countryStatisticsStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            countryStatisticsStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            globalStatisticsStackView.topAnchor.constraint(equalTo: countryStatisticsStackView.bottomAnchor, constant: 30),
            globalStatisticsStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            globalStatisticsStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            globalStatisticsStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    func activityIndicator() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.backgroundColor = Colors.black
        indicator.style = .white
        indicator.hidesWhenStopped = true
        view.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        indicator.startAnimating()
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(countryStatisticsStackView)
        scrollView.addSubview(globalStatisticsStackView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isHidden = true
        
        var constraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        
        if #available(iOS 11.0, *) {
            constraints.append(scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
            constraints.append(scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        } else {
            constraints.append(scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20))
            constraints.append(scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -49))
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func addGestureByCountryStackView() {
        countryStatisticsStackView.titleLabel.isUserInteractionEnabled = true
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapChangeCountry))
        countryStatisticsStackView.titleLabel.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - Active
    
    @objc private func tapChangeCountry() {
        presenter.changeCountry()
    }
}


// MARK: - StatisticsViewInput
extension StatisticsViewController: StatisticsViewInput {
    
    func success(global: Statistics, country: Statistics) {
        
        changeStatisticsView(statisticsView: countryStatisticsStackView, statistics: country)
        changeStatisticsView(statisticsView: globalStatisticsStackView, statistics: global)
        
        indicator.stopAnimating()
        scrollView.isHidden = false
    }
    
    func failure() {
        indicator.stopAnimating()
        scrollView.isHidden = false
        presenter.presentFailureAlert(title: Errors.error, message: Errors.network)
    }
    
    private func changeStatisticsView(statisticsView: StatisticsStackView, statistics: Statistics) {
        
        //statisticsView.titleLabel.text = statistics.country
        statisticsView.numberConfirmedLabel.text = "\(Int(statistics.confirmed).formattedWithSeparator)"
        statisticsView.numberDeathsLabel.text = "\(Int(statistics.deaths).formattedWithSeparator)"
        statisticsView.numberRecoveredLabel.text = "\(Int(statistics.recovered).formattedWithSeparator)"
        statisticsView.incConfirmedLabel.text = "+\(Int(statistics.incConfirmed).formattedWithSeparator)"
        statisticsView.incDeathsLabel.text = "+\(Int(statistics.incDeaths).formattedWithSeparator)"
        statisticsView.incRecoveredLabel.text = "+\(Int(statistics.incRecoverded).formattedWithSeparator)"
    }
}
