//
//  CountryCell.swift
//  Covid
//
//  Created by Kirill Selivanov on 08.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class CountryCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let nameCountryLabel = UILabel()
    private let totalStatusLabel = UILabel()
    private let newStatusLabel = UILabel()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Colors.gray
        selectionStyle = .none
        configureNameCountryLabel()
        configureNumberAndIncStack()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Configurations
    
    private func configureNameCountryLabel() {
        nameCountryLabel.textColor = Colors.black
        nameCountryLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameCountryLabel)
        NSLayoutConstraint.activate([
            nameCountryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameCountryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            nameCountryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
    
    private func configureNumberAndIncStack() {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .trailing
        stack.spacing = 5
        stack.addArrangedSubview(totalStatusLabel)
        stack.addArrangedSubview(newStatusLabel)
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    func updateContent(statistics: StatisticsModel, status: Status) {
        
        nameCountryLabel.text = statistics.name
        switch status {
        case .confirmed:
            totalStatusLabel.textColor = Colors.orange
            totalStatusLabel.text = "\(statistics.totalConfirmed.formattedWithSeparator)"
            newStatusLabel.textColor = Colors.orange
            newStatusLabel.text = "+\(statistics.newConfirmed.formattedWithSeparator)"
        case .deaths:
            totalStatusLabel.textColor = Colors.red
            totalStatusLabel.text = "\(statistics.totalDeaths.formattedWithSeparator)"
            newStatusLabel.textColor = Colors.red
            newStatusLabel.text = "+\(statistics.newDeaths.formattedWithSeparator)"
        case .recoverded:
            totalStatusLabel.textColor = Colors.green
            totalStatusLabel.text = "\(statistics.totalRecovered.formattedWithSeparator)"
            newStatusLabel.textColor = Colors.green
            newStatusLabel.text = "+\(statistics.newRecovered.formattedWithSeparator)"
        }
    }
}
