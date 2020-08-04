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
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollView.isHidden = true
        indicator.startAnimating()
        presenter.getData()
    }
    
    // MARK: - Configurations View
    
    private func setupView() {
        view.backgroundColor = Colors.black
        
        activityIndicator()
        configureScrollView()
        
        NSLayoutConstraint.activate([
            countryStatisticsStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            countryStatisticsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constraints.leadingOfView),
            countryStatisticsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constraints.trailingOfView),
            globalStatisticsStackView.topAnchor.constraint(equalTo: countryStatisticsStackView.bottomAnchor, constant: Constraints.spacingCountryAndGlobalStack),
            globalStatisticsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constraints.leadingOfView),
            globalStatisticsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constraints.trailingOfView),
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
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(countryStatisticsStackView)
        scrollView.addSubview(globalStatisticsStackView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constraints.leadingOfView),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constraints.trailingOfView)
        ]
        
        if #available(iOS 11.0, *) {
            constraints.append(scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constraints.topOfView))
            constraints.append(scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        } else {
            constraints.append(scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: Constraints.safeAreaTop + Constraints.safeAreaTop))
            constraints.append(scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constraints.heightOfTabBar))
        }
        
        NSLayoutConstraint.activate(constraints)
    }
}


// MARK: - StatisticsViewInput
extension StatisticsViewController: StatisticsViewInput {
    
    func success(global: Statistics, country: Statistics) {
        
        countryStatisticsStackView.changeStatisticsView(statistics: country)
        globalStatisticsStackView.changeStatisticsView(statistics: global)
        
        indicator.stopAnimating()
        scrollView.isHidden = false
    }
    
    func failure() {
        indicator.stopAnimating()
        scrollView.isHidden = false
        presenter.presentFailureAlert(title: Errors.error, message: Errors.network)
    }
}
