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
    
    private let contentView = UIView()
    private let scrollView = UIScrollView()
    private let indicator = UIActivityIndicatorView()
    private let countryStatisticsStackView = StatisticsStackView()
    private let globalStatisticsStackView = StatisticsStackView()
    
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
        indicator.startAnimating()

        configureScrollView()
        configureContentView()

        contentView.addSubview(countryStatisticsStackView)
        addGestureByCountryStackView()
        contentView.addSubview(globalStatisticsStackView)
        
        NSLayoutConstraint.activate([
            countryStatisticsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            countryStatisticsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            globalStatisticsStackView.topAnchor.constraint(equalTo: countryStatisticsStackView.bottomAnchor, constant: 25),
            globalStatisticsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            globalStatisticsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func activityIndicator() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.backgroundColor = Colors.black
        indicator.style = .white
        indicator.hidesWhenStopped = true
        view.addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func configureContentView() {
        scrollView.addSubview(contentView)
        scrollView.isHidden = true
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
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -49).isActive = true
        }
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
        presenter.presentFailureAlert(title: "Ошибка", message: "Не удалось получить данные")
    }
    
    private func changeStatisticsView(statisticsView: StatisticsStackView, statistics: Statistics) {
        
        statisticsView.titleLabel.text = statistics.country
        statisticsView.numberConfirmedLabel.text = "\(Int(statistics.confirmed).formattedWithSeparator)"
        statisticsView.numberDeathsLabel.text = "\(Int(statistics.deaths).formattedWithSeparator)"
        statisticsView.numberRecoveredLabel.text = "\(Int(statistics.recovered).formattedWithSeparator)"
        statisticsView.incConfirmedLabel.text = "+\(Int(statistics.incConfirmed).formattedWithSeparator)"
        statisticsView.incDeathsLabel.text = "+\(Int(statistics.incDeaths).formattedWithSeparator)"
        statisticsView.incRecoveredLabel.text = "+\(Int(statistics.incRecoverded).formattedWithSeparator)"
    }
}
