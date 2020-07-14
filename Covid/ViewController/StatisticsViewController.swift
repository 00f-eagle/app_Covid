//
//  StatisticsViewController.swift
//  Covid
//
//  Created by Kirill Selivanov on 30.06.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class StatisticsViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Colors {
        static let red = UIColor(red: 230/255.0, green: 70/255.0, blue: 70/255.0, alpha: 1)
        static let orange = UIColor(red: 240/255.0, green: 150/255.0, blue: 50/255.0, alpha: 1)
        static let green = UIColor(red: 100/255.0, green: 200/255.0, blue: 100/255.0, alpha: 1)
        static let white = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        static let black = UIColor(red: 30/255.0, green: 30/255.0, blue: 40/255.0, alpha: 1)
    }
    
    private enum Texts {
        static let world = "Мир     "
        static let country = "Россия"
        static let confirmed = "Подтверждено"
        static let deaths = "Смертей"
        static let recovered = "Выздоровлений"
        static let chooseCountry = "Выбрать страну"
    }

    // MARK: - Properties
    
    var presenter: StatisticsPresenter!
    
    private let contentView = UIView()
    private let scrollView = UIScrollView()
    
    private let titleNameCountryLabel = UILabel()
    private let numberCountryConfirmedLabel = UILabel()
    private let numberCountryDeathsLabel = UILabel()
    private let numberCountryRecoveredLabel = UILabel()
    private let incCountryConfirmedLabel = UILabel()
    private let incCountryDeathsLabel = UILabel()
    private let incCountryRecoveredLabel = UILabel()
    
    private let titleWorldLabel = UILabel()
    private let numberWorldConfirmedLabel = UILabel()
    private let numberWorldDeathsLabel = UILabel()
    private let numberWorldRecoveredLabel = UILabel()
    private let incWorldConfirmedLabel = UILabel()
    private let incWorldDeathsLabel = UILabel()
    private let incWorldRecoveredLabel = UILabel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.black
        setupView()
        presenter.getData()
    }
    
    // MARK: - Configurations View
    
    private func setupView() {
        
        configureMainTitleLabel(label: titleNameCountryLabel, text: Texts.country)
        configureNumberStatusLabel(label: numberCountryConfirmedLabel, text: "710 067", color: Colors.orange)
        configureIncStatusLabel(label: incCountryConfirmedLabel, text: "+5 321", color: Colors.orange)
        configureNumberStatusLabel(label: numberCountryDeathsLabel, text: "10 432", color: Colors.red)
        configureIncStatusLabel(label: incCountryDeathsLabel, text: "+93", color: Colors.red)
        configureNumberStatusLabel(label: numberCountryRecoveredLabel, text: "492 312", color: Colors.green)
        configureIncStatusLabel(label: incCountryRecoveredLabel, text: "+3 900", color: Colors.green)
        
        configureMainTitleLabel(label: titleWorldLabel, text: Texts.world)
        configureNumberStatusLabel(label: numberWorldConfirmedLabel, text: "10 381 892", color: Colors.orange)
        configureIncStatusLabel(label: incWorldConfirmedLabel, text: "+51 192", color: Colors.orange)
        configureNumberStatusLabel(label: numberWorldDeathsLabel, text: "501 231", color: Colors.red)
        configureIncStatusLabel(label: incWorldDeathsLabel, text: "+4 891", color: Colors.red)
        configureNumberStatusLabel(label: numberWorldRecoveredLabel, text: "5 123 905", color: Colors.green)
        configureIncStatusLabel(label: incWorldRecoveredLabel, text: "+73 910", color: Colors.green)
        
        configureContentView()
        configureScrollView()
        
        let countryStack = configureStatusStack(mainLabel: titleNameCountryLabel, numberConfirmedLabel: numberCountryConfirmedLabel, incConfirmedLabel: incCountryConfirmedLabel, numberDeathsLabel: numberCountryDeathsLabel, incDeathsLabel: incCountryDeathsLabel, numberRecoveredLabel: numberCountryRecoveredLabel, incRecoveredLabel: incCountryRecoveredLabel)
        
        let worldStack = configureStatusStack(mainLabel: titleWorldLabel, numberConfirmedLabel: numberWorldConfirmedLabel, incConfirmedLabel: incWorldConfirmedLabel, numberDeathsLabel: numberWorldDeathsLabel, incDeathsLabel: incWorldDeathsLabel, numberRecoveredLabel: numberWorldRecoveredLabel, incRecoveredLabel: incWorldRecoveredLabel)
       
        NSLayoutConstraint.activate([
            countryStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            countryStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            worldStack.topAnchor.constraint(equalTo: countryStack.bottomAnchor, constant: 25),
            worldStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            worldStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func configureMainTitleLabel(label: UILabel, text: String) {
           contentView.addSubview(label)
           label.text = text
           label.textColor = Colors.white
           label.font = .systemFont(ofSize: 30, weight: UIFont.Weight.bold)
           label.translatesAutoresizingMaskIntoConstraints = false
           label.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
           label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
    }
    
    private func configureNumberStatusLabel(label: UILabel, text: String, color: UIColor) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = color
    }
    
    private func configureIncStatusLabel(label: UILabel, text: String, color: UIColor) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = .systemFont(ofSize: 17, weight: .heavy)
        label.textColor = color
    }
    
    private func configureStatusStack(mainLabel: UILabel, numberConfirmedLabel: UILabel, incConfirmedLabel: UILabel, numberDeathsLabel: UILabel, incDeathsLabel: UILabel, numberRecoveredLabel: UILabel, incRecoveredLabel: UILabel) -> UIStackView {
        let stack = UIStackView()
        
        let titleConfirmedLabel = configureTitleNameLabel(text: Texts.confirmed, color: Colors.white)
        let titleDeathsLabel = configureTitleNameLabel(text: Texts.deaths, color: Colors.white)
        let titleRecoveredLabel = configureTitleNameLabel(text: Texts.recovered, color: Colors.white)
        
        let numberConfirmedStack = configureNumberStack(labelOne: numberConfirmedLabel, labelTwo: incConfirmedLabel)
        let numberDeathsStack = configureNumberStack(labelOne: numberDeathsLabel, labelTwo: incDeathsLabel)
        let numberRecoveredStack =  configureNumberStack(labelOne: numberRecoveredLabel, labelTwo: incRecoveredLabel)
        
        let confirmedStack = configureNumberAndTitleStack(label: titleConfirmedLabel, numberStack: numberConfirmedStack)
        let deathsStack = configureNumberAndTitleStack(label: titleDeathsLabel, numberStack: numberDeathsStack)
        let recoveredStack = configureNumberAndTitleStack(label: titleRecoveredLabel, numberStack: numberRecoveredStack)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 25
        stack.addArrangedSubview(mainLabel)
        stack.addArrangedSubview(confirmedStack)
        stack.addArrangedSubview(deathsStack)
        stack.addArrangedSubview(recoveredStack)
        contentView.addSubview(stack)
        return stack
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
    
    private func configureTitleNameLabel(text: String, color: UIColor) -> UILabel {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.text = text
           label.font = .systemFont(ofSize: 16, weight: UIFont.Weight.light)
           label.textColor = color
           return label
    }
    
    private func configureNumberStack(labelOne: UILabel, labelTwo: UILabel) -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 15
        stack.addArrangedSubview(labelOne)
        stack.addArrangedSubview(labelTwo)
        return stack
    }
    
    private func configureNumberAndTitleStack(label: UILabel, numberStack: UIStackView) -> UIStackView{
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(numberStack)
        return stack
    }
    
    func setStatus() {
        self.numberWorldConfirmedLabel.text = presenter.numberGlobalConfirmed
    }
}

extension StatisticsViewController: StatisticsViewProtocol {
    func succes() {
        
        numberCountryConfirmedLabel.text = presenter.numberCountryConfirmed
        numberCountryDeathsLabel.text = presenter.numberCountryDeaths
        numberCountryRecoveredLabel.text = presenter.numberCountryRecovered
        incCountryConfirmedLabel.text = presenter.incCountryConfirmed
        incCountryDeathsLabel.text = presenter.incCountryDeaths
        incCountryRecoveredLabel.text = presenter.incCountryRecovered
        
        
        numberWorldConfirmedLabel.text = presenter.numberGlobalConfirmed
        numberWorldDeathsLabel.text = presenter.numberGlobalDeaths
        numberWorldRecoveredLabel.text = presenter.numberGlobalRecovered
        incWorldConfirmedLabel.text = presenter.incGlobalConfirmed
        incWorldDeathsLabel.text = presenter.incGlobalDeaths
        incWorldRecoveredLabel.text = presenter.incGlobalRecovered
    }
    
    func failure() {
        print("Сделать аллерт с ошибкой получения данных!")
    }
}
