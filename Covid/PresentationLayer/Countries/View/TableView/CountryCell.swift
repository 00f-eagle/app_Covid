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
    var statisticsOfStatus: StatisticsOfStatusModel? {
        didSet {
            if let statisticsOfStatus = statisticsOfStatus {
                updateContent(statistics: statisticsOfStatus)
            }
        }
    }
    var status: Status? {
        didSet {
            if let status = status {
                updateColors(status: status)
            }
        }
    }
    
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
    
    private func updateContent(statistics: StatisticsOfStatusModel) {
        nameCountryLabel.text = statistics.name
        totalStatusLabel.text = "+\(statistics.total.formattedWithSeparator)"
        newStatusLabel.text = "+\(statistics.new.formattedWithSeparator)"
    }
    
    private func updateColors(status: Status) {
        switch status {
        case .confirmed:
            totalStatusLabel.textColor = Colors.orange
            newStatusLabel.textColor = Colors.orange
        case .deaths:
            totalStatusLabel.textColor = Colors.red
            newStatusLabel.textColor = Colors.red
        case .recovered:
            totalStatusLabel.textColor = Colors.green
            newStatusLabel.textColor = Colors.green
        }
        
    }
}
