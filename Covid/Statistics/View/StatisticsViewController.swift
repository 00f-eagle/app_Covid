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
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -49).isActive = true
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
    
    func success(global: Statistics, country: Statistics) {
        
        changeStatisticsView(statisticsView: countryStatisticsView, statistics: country)
        changeStatisticsView(statisticsView: globalStatisticsView, statistics: global)
    }
    
    func failure() {
        presenter.presentFailureAlert(title: "Ошибка", message: "Не удалось получить данные")
    }
    
    private func changeStatisticsView(statisticsView: StatisticsView, statistics: Statistics) {
        statisticsView.titleLabel.text = statistics.country
        statisticsView.numberConfirmedLabel.text = "\(Int(statistics.confirmed).formattedWithSeparator)"
        statisticsView.numberDeathsLabel.text = "\(Int(statistics.deaths).formattedWithSeparator)"
        statisticsView.numberRecoveredLabel.text = "\(Int(statistics.recovered).formattedWithSeparator)"
        statisticsView.incConfirmedLabel.text = "+\(Int(statistics.incConfirmed).formattedWithSeparator)"
        statisticsView.incDeathsLabel.text = "+\(Int(statistics.incDeaths).formattedWithSeparator)"
        statisticsView.incRecoveredLabel.text = "+\(Int(statistics.incRecoverded).formattedWithSeparator)"
    }
}
