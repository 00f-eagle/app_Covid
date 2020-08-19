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
    
    var presenter: CountryViewOutput!
    
    private let indicator = UIActivityIndicatorView()
    private let scrollView = UIScrollView()
    private let buttonsStack = UIStackView()
    private let countryStatisticsStackView = StatisticsStackView()
    private let graph = GraphView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getData()
    }
    
    // MARK: - Configurations
    
    private func setupView() {
        view.backgroundColor = Colors.white
        configureActivityIndicator()
        configureButtonsStack()
        configureScrollView()
        configureStatisticsStack()
        configureGraph()
    }
    
    private func configureActivityIndicator() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.startAnimating()
        view.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func configureButtonsStack() {
        let backButton = createButton(text: Texts.back, action: #selector(backAction))
        let defaultButton = createButton(text: Texts.setupDefault, action: #selector(defaultCountryAction))
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        buttonsStack.addArrangedSubview(backButton)
        buttonsStack.addArrangedSubview(defaultButton)
        buttonsStack.axis = .horizontal
        buttonsStack.distribution = .fillEqually
        buttonsStack.spacing = 10
        view.addSubview(buttonsStack)
        
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                buttonsStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.leading),
                buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.trailing)
            ])
        } else {
            NSLayoutConstraint.activate([
                buttonsStack.topAnchor.constraint(equalTo: view.topAnchor, constant: Margin.safeAreaTop),
                buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.leading),
                buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.trailing)
            ])
        }
    }
    
    private func createButton(text: String, action: Selector) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.setTitle(text, for: .normal)
        button.setTitleColor(Colors.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .medium)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.backgroundColor = Colors.gray
        button.layer.cornerRadius = Margin.cornerRadius
        return button
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(countryStatisticsStackView)
        scrollView.addSubview(graph)
        scrollView.isHidden = true
        if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: buttonsStack.bottomAnchor, constant: Margin.top),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.leading),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.trailing),
                scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: Margin.bottom)
            ])
        } else {
            NSLayoutConstraint.activate([
                scrollView.topAnchor.constraint(equalTo: buttonsStack.bottomAnchor, constant: Margin.top),
                scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.leading),
                scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.trailing),
                scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Margin.bottom)
            ])
        }
    }
    
    private func configureStatisticsStack() {
        NSLayoutConstraint.activate([
            countryStatisticsStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            countryStatisticsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.leading),
            countryStatisticsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.trailing)
        ])
    }
    
    private func configureGraph() {
        NSLayoutConstraint.activate([
            graph.topAnchor.constraint(equalTo: countryStatisticsStackView.bottomAnchor, constant: 10),
            graph.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Margin.leading),
            graph.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Margin.trailing),
            graph.heightAnchor.constraint(equalToConstant: 200),
            graph.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
    
    // MARK: - Action
    
    @objc private func backAction() {
        presenter.dismissView()
    }
    
    @objc private func defaultCountryAction() {
        presenter.changeDefaultCountry()
    }
    
}


// MARK: - CountryViewInput
extension CountryViewController: CountryViewInput {
    func success(statistics: StatisticsModel, dayOne: [[String : [Int]]]?) {
        countryStatisticsStackView.changeStatisticsView(statistics: statistics)
        
        if let dayOne = dayOne {
            graph.changeGraphPoints(data: dayOne)
            graph.isHidden = false
        } else {
            graph.isHidden = true
        }
        
        indicator.stopAnimating()
        scrollView.isHidden = false
    }
    
    func failure() {
        presenter.presentFailureAlert(title: Errors.error, message: Errors.data)
    }
}
