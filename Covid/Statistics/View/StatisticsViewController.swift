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
    private let statisticsStackViewOne = StatisticsStackView()
    private let statisticsStackViewTwo = StatisticsStackView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.black
        setupView()
        presenter.updateView()
        
        // Где-то в этом классе будет вызов presenter.exampleForRouter()
    }
    
    // MARK: - Configurations View
    
    private func setupView() {
        configureScrollView()
        configureContentView()
        let stackOne = statisticsStackViewOne.configureStatisticsStackView()
        let stackTwo = statisticsStackViewTwo.configureStatisticsStackView()
        
        contentView.addSubview(stackOne)
        contentView.addSubview(stackTwo)
        
        NSLayoutConstraint.activate([
            stackOne.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            stackOne.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackTwo.topAnchor.constraint(equalTo: stackOne.bottomAnchor, constant: 25),
            stackTwo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackTwo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
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
}


// MARK: - StatisticsViewInput
extension StatisticsViewController: StatisticsViewInput {
    
    func succes(numberGlobal: [String], numberCountries: [String]) {
        statisticsStackViewOne.titleLabel.text = "Россия"
        statisticsStackViewOne.numberConfirmedLabel.text = numberCountries[0]
        statisticsStackViewOne.numberDeathsLabel.text = numberCountries[1]
        statisticsStackViewOne.numberRecoveredLabel.text = numberCountries[2]
        statisticsStackViewOne.incConfirmedLabel.text = numberCountries[3]
        statisticsStackViewOne.incDeathsLabel.text = numberCountries[4]
        statisticsStackViewOne.incRecoveredLabel.text = numberCountries[5]
        
        statisticsStackViewTwo.titleLabel.text = "Мир"
        statisticsStackViewTwo.numberConfirmedLabel.text = numberGlobal[0]
        statisticsStackViewTwo.numberDeathsLabel.text = numberGlobal[1]
        statisticsStackViewTwo.numberRecoveredLabel.text = numberGlobal[2]
        statisticsStackViewTwo.incConfirmedLabel.text = numberGlobal[3]
        statisticsStackViewTwo.incDeathsLabel.text = numberGlobal[4]
        statisticsStackViewTwo.incRecoveredLabel.text = numberGlobal[5]
    }
    
    func failure() {
        print("Сделать аллерт с ошибкой получения данных!")
    }
}
