//
//  StatisticsView.swift
//  Covid
//
//  Created by Kirill Selivanov on 15.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class StatisticsView: UIView {
    
    // MARK: - Properties
    
    let titleLabel = UILabel()
    let numberConfirmedLabel = UILabel()
    let numberDeathsLabel = UILabel()
    let numberRecoveredLabel = UILabel()
    let incConfirmedLabel = UILabel()
    let incDeathsLabel = UILabel()
    let incRecoveredLabel = UILabel()
    
    // MARK: - Configurations
    
    func configureStatisticsStackView() -> UIStackView{
        
        configureTitleLabel()
        
        configureLabel(label: numberConfirmedLabel, text: Texts.unknown, color: Colors.orange)
        configureLabel(label: incConfirmedLabel, text: Texts.unknown, color: Colors.orange)
        configureLabel(label: numberDeathsLabel, text: Texts.unknown, color: Colors.red)
        configureLabel(label: incDeathsLabel, text: Texts.unknown, color: Colors.red)
        configureLabel(label: numberRecoveredLabel, text: Texts.unknown, color: Colors.green)
        configureLabel(label: incRecoveredLabel, text: Texts.unknown, color: Colors.green)
        
        let titleConfirmedLabel = configureTitleStatusLabel(text: Texts.confirmed, color: Colors.orange)
        let titleDeathsLabel = configureTitleStatusLabel(text: Texts.deaths, color: Colors.red)
        let titleRecoveredLabel = configureTitleStatusLabel(text: Texts.recovered, color: Colors.green)
        
        let numberAndIncConfirmedStack = configureNumberAndIncStack(labelOne: numberConfirmedLabel, labelTwo: incConfirmedLabel)
        let numberAndIncDeathsStack = configureNumberAndIncStack(labelOne: numberDeathsLabel, labelTwo: incDeathsLabel)
        let numberAndIncRecoveredStack =  configureNumberAndIncStack(labelOne: numberRecoveredLabel, labelTwo: incRecoveredLabel)
        
        let confirmedStack = configureNumberAndTitleStack(label: titleConfirmedLabel, numberStack: numberAndIncConfirmedStack)
        let deathsStack = configureNumberAndTitleStack(label: titleDeathsLabel, numberStack: numberAndIncDeathsStack)
        let recoveredStack = configureNumberAndTitleStack(label: titleRecoveredLabel, numberStack: numberAndIncRecoveredStack)
        
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 25
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(confirmedStack)
        stack.addArrangedSubview(deathsStack)
        stack.addArrangedSubview(recoveredStack)
        return stack
    }
    
    private func configureTitleLabel() {
        titleLabel.text = Texts.unknown
        titleLabel.textColor = Colors.white
        titleLabel.font = .systemFont(ofSize: 30, weight: .heavy)
    }
    
    private func configureLabel(label: UILabel, text: String, color: UIColor){
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
        
        if #available(iOS 11.0, *) {
            stack.setCustomSpacing(10, after: labelOne)
        } else {
            stack.spacing = 10
        }
        
        labelOne.setContentHuggingPriority(.defaultHigh, for: .vertical)
        labelOne.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        labelTwo.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        labelTwo.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return stack
    }
    
    private func configureNumberAndTitleStack(label: UILabel, numberStack: UIStackView) -> UIStackView{
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(numberStack)
        return stack
    }
}
