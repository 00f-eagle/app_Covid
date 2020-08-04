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
    private let numberStatusLabel = UILabel()
    private let incStatusLabel = UILabel()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Colors.black
        
        configureNameCountryLabel()
        configureNumberAndIncStack()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Configurations
    
    private func configureNameCountryLabel() {
        nameCountryLabel.textColor = Colors.white
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
        stack.addArrangedSubview(numberStatusLabel)
        stack.addArrangedSubview(incStatusLabel)
        addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    
    func updateContent(countryModel: Statistics, status: Status) {
        
        nameCountryLabel.text = countryModel.country
        switch status {
        case .confirmed:
            numberStatusLabel.textColor = Colors.orange
            numberStatusLabel.text = "\(Int(countryModel.confirmed).formattedWithSeparator)"
            incStatusLabel.textColor = Colors.orange
            incStatusLabel.text = "+\(Int(countryModel.incConfirmed).formattedWithSeparator)"
        case .deaths:
            numberStatusLabel.textColor = Colors.red
            numberStatusLabel.text = "\(Int(countryModel.deaths).formattedWithSeparator)"
            incStatusLabel.textColor = Colors.red
            incStatusLabel.text = "+\(Int(countryModel.incDeaths).formattedWithSeparator)"
        case .recoverded:
            numberStatusLabel.textColor = Colors.green
            numberStatusLabel.text = "\(Int(countryModel.recovered).formattedWithSeparator)"
            incStatusLabel.textColor = Colors.green
            incStatusLabel.text = "+\(Int(countryModel.incRecoverded).formattedWithSeparator)"
        }
    }
}
