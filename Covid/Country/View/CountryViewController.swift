//
//  CountryViewController.swift
//  Covid
//
//  Created by Kirill Selivanov on 02.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class CountryViewController: UIViewController {
    
    // MARK: - Properties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var presenter: CountryViewOutput!
    var country: String!
    
    private let scrollView = UIScrollView()
    private let backButton = UIButton()
    private let countryStatisticsStackView = StatisticsStackView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.black
        
        setupView()
        presenter.loadData(country: country)
    }
    
    // MARK: - Configurations
    
    private func setupView() {
        
        configureBackButton()
        configureScrollView()
        
        NSLayoutConstraint.activate([
            countryStatisticsStackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            countryStatisticsStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            countryStatisticsStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
    }
    
    private func configureBackButton() {
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle("< Назад", for: .normal)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        var constraints = [backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)]
        
        if #available(iOS 11.0, *) {
            constraints.append(backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor))
        } else {
            constraints.append(backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20))
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(countryStatisticsStackView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [
            scrollView.topAnchor.constraint(equalTo: backButton.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ]
        
        if #available(iOS 11.0, *) {
            constraints.append(scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        } else {
            constraints.append(scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -49))
        }
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Action
    
    @objc private func backAction() {
        presenter.dismissView()
    }
    
}


// MARK: - CountryViewInput
extension CountryViewController: CountryViewInput {
    func success(statistics: Statistics) {
        countryStatisticsStackView.titleLabel.text = statistics.country
        countryStatisticsStackView.numberConfirmedLabel.text = "\(Int(statistics.confirmed).formattedWithSeparator)"
        countryStatisticsStackView.numberDeathsLabel.text = "\(Int(statistics.deaths).formattedWithSeparator)"
        countryStatisticsStackView.numberRecoveredLabel.text = "\(Int(statistics.recovered).formattedWithSeparator)"
        countryStatisticsStackView.incConfirmedLabel.text = "+\(Int(statistics.incConfirmed).formattedWithSeparator)"
        countryStatisticsStackView.incDeathsLabel.text = "+\(Int(statistics.incDeaths).formattedWithSeparator)"
        countryStatisticsStackView.incRecoveredLabel.text = "+\(Int(statistics.incRecoverded).formattedWithSeparator)"
    }
    
    func failure() {
        presenter.presentFailureAlert(title: Errors.error, message: Errors.data)
    }
}
