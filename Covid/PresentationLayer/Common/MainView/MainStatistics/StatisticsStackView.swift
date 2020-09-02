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
    private let totalConfirmedLabel = UILabel()
    private let totalDeathsLabel = UILabel()
    private let totalRecoveredLabel = UILabel()
    private let newConfirmedLabel = UILabel()
    private let newDeathsLabel = UILabel()
    private let newRecoveredLabel = UILabel()
    private let date = UILabel()
    
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
        configureDate()
        configureLabel(label: totalConfirmedLabel, text: Texts.null, color: Colors.orange)
        configureLabel(label: newConfirmedLabel, text: "+\(Texts.null)", color: Colors.orange)
        configureLabel(label: totalDeathsLabel, text: Texts.null, color: Colors.red)
        configureLabel(label: newDeathsLabel, text: "+\(Texts.null)", color: Colors.red)
        configureLabel(label: totalRecoveredLabel, text: Texts.null, color: Colors.green)
        configureLabel(label: newRecoveredLabel, text: "+\(Texts.null)", color: Colors.green)
        
        let titleConfirmedLabel = configureTitleStatusLabel(text: Texts.confirmed, color: Colors.orange)
        let titleDeathsLabel = configureTitleStatusLabel(text: Texts.deaths, color: Colors.red)
        let titleRecoveredLabel = configureTitleStatusLabel(text: Texts.recovered, color: Colors.green)
        
        let totalAndNewConfirmedStack = configureTotalAndNewStack(labelOne: totalConfirmedLabel, labelTwo: newConfirmedLabel)
        let totalAndNewDeathsStack = configureTotalAndNewStack(labelOne: totalDeathsLabel, labelTwo: newDeathsLabel)
        let totalAndNewRecoveredStack =  configureTotalAndNewStack(labelOne: totalRecoveredLabel, labelTwo: newRecoveredLabel)
        
        let confirmedStack = configureNumberAndTitleStack(label: titleConfirmedLabel, numberStack: totalAndNewConfirmedStack)
        let deathsStack = configureNumberAndTitleStack(label: titleDeathsLabel, numberStack: totalAndNewDeathsStack)
        let recoveredStack = configureNumberAndTitleStack(label: titleRecoveredLabel, numberStack: totalAndNewRecoveredStack)
        
        translatesAutoresizingMaskIntoConstraints = false
        axis = .vertical
        spacing = 20
        addBackground(color: Colors.gray, cornerRadius: Margin.cornerRadius)
        addArrangedSubview(titleLabel)
        addArrangedSubview(confirmedStack)
        addArrangedSubview(deathsStack)
        addArrangedSubview(recoveredStack)
        addArrangedSubview(date)
    }
    
    private func configureTitleLabel() {
        titleLabel.textColor = Colors.black
        titleLabel.text = Texts.unknown
        titleLabel.font = .systemFont(ofSize: 30, weight: .heavy)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
    }
    
    private func configureDate() {
        date.textColor = Colors.black
        date.text = Texts.dateDefault
        date.font = .systemFont(ofSize: 10, weight: .light)
        date.textAlignment = .right
    }
    
    private func configureLabel(label: UILabel, text: String, color: UIColor) {
        label.textColor = color
        label.text = text
        label.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private func configureTitleStatusLabel(text: String, color: UIColor) -> UILabel {
        let label = UILabel()
        configureLabel(label: label, text: text, color: color)
        label.textAlignment = .center
        return label
    }
    
    private func configureTotalAndNewStack(labelOne: UILabel, labelTwo: UILabel) -> UIStackView {
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
        stack.spacing = 15
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(numberStack)
        stack.alignment = .center
        return stack
    }
    
    func updateStatistics(statistics: StatisticsModel) {
        titleLabel.text = statistics.name
        totalConfirmedLabel.text = "\(statistics.totalConfirmed.formattedWithSeparator)"
        totalDeathsLabel.text = "\(statistics.totalDeaths.formattedWithSeparator)"
        totalRecoveredLabel.text = "\(statistics.totalRecovered.formattedWithSeparator)"
        newConfirmedLabel.text = "+\(statistics.newConfirmed.formattedWithSeparator)"
        newDeathsLabel.text = "+\(statistics.newDeaths.formattedWithSeparator)"
        newRecoveredLabel.text = "+\(statistics.newRecovered.formattedWithSeparator)"
        date.text = statistics.date
    }
}
