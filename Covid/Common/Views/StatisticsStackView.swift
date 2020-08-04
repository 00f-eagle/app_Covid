//
//  StatisticsView.swift
//  Covid
//
//  Created by Kirill Selivanov on 15.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class StatisticsStackView: UIStackView {
    
    // MARK: - Properties
    
    private let titleLabel = UILabel()
    private let numberConfirmedLabel = UILabel()
    private let numberDeathsLabel = UILabel()
    private let numberRecoveredLabel = UILabel()
    private let incConfirmedLabel = UILabel()
    private let incDeathsLabel = UILabel()
    private let incRecoveredLabel = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStatisticsStackView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Configurations
    
    private func configureStatisticsStackView() {
        
        configureTitleLabel()
        
        configureLabel(label: numberConfirmedLabel, text: Texts.null, color: Colors.orange)
        configureLabel(label: incConfirmedLabel, text: "+\(Texts.null)", color: Colors.orange)
        configureLabel(label: numberDeathsLabel, text: Texts.null, color: Colors.red)
        configureLabel(label: incDeathsLabel, text: "+\(Texts.null)", color: Colors.red)
        configureLabel(label: numberRecoveredLabel, text: Texts.null, color: Colors.green)
        configureLabel(label: incRecoveredLabel, text: "+\(Texts.null)", color: Colors.green)
        
        let titleConfirmedLabel = configureTitleStatusLabel(text: Texts.confirmed, color: Colors.orange)
        let titleDeathsLabel = configureTitleStatusLabel(text: Texts.deaths, color: Colors.red)
        let titleRecoveredLabel = configureTitleStatusLabel(text: Texts.recovered, color: Colors.green)
        
        let numberAndIncConfirmedStack = configureNumberAndIncStack(labelOne: numberConfirmedLabel, labelTwo: incConfirmedLabel)
        let numberAndIncDeathsStack = configureNumberAndIncStack(labelOne: numberDeathsLabel, labelTwo: incDeathsLabel)
        let numberAndIncRecoveredStack =  configureNumberAndIncStack(labelOne: numberRecoveredLabel, labelTwo: incRecoveredLabel)
        
        let confirmedStack = configureNumberAndTitleStack(label: titleConfirmedLabel, numberStack: numberAndIncConfirmedStack)
        let deathsStack = configureNumberAndTitleStack(label: titleDeathsLabel, numberStack: numberAndIncDeathsStack)
        let recoveredStack = configureNumberAndTitleStack(label: titleRecoveredLabel, numberStack: numberAndIncRecoveredStack)
        
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        spacing = 25
        addArrangedSubview(titleLabel)
        addArrangedSubview(confirmedStack)
        addArrangedSubview(deathsStack)
        addArrangedSubview(recoveredStack)
    }
    
    private func configureTitleLabel() {
        titleLabel.textColor = Colors.white
        titleLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        titleLabel.numberOfLines = 0
    }
    
    private func configureLabel(label: UILabel, text: String, color: UIColor) {
        label.textColor = color
        label.text = text
        label.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private func configureTitleStatusLabel(text: String, color: UIColor) -> UILabel {
        let label = UILabel()
        configureLabel(label: label, text: text, color: color)
        return label
    }
    
    private func configureNumberAndIncStack(labelOne: UILabel, labelTwo: UILabel) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.addArrangedSubview(labelOne)
        stack.addArrangedSubview(labelTwo)
        stack.spacing = 10
        labelOne.setContentHuggingPriority(.defaultHigh, for: .vertical)
        labelOne.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        labelTwo.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        labelTwo.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return stack
    }
    
    private func configureNumberAndTitleStack(label: UILabel, numberStack: UIStackView) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(numberStack)
        return stack
    }
    
    func changeStatisticsView(statistics: Statistics) {
        titleLabel.text = statistics.country
        numberConfirmedLabel.text = "\(Int(statistics.confirmed).formattedWithSeparator)"
        numberDeathsLabel.text = "\(Int(statistics.deaths).formattedWithSeparator)"
        numberRecoveredLabel.text = "\(Int(statistics.recovered).formattedWithSeparator)"
        incConfirmedLabel.text = "+\(Int(statistics.incConfirmed).formattedWithSeparator)"
        incDeathsLabel.text = "+\(Int(statistics.incDeaths).formattedWithSeparator)"
        incRecoveredLabel.text = "+\(Int(statistics.incRecoverded).formattedWithSeparator)"
    }
}
