//
//  CountryCell.swift
//  Covid
//
//  Created by Kirill Selivanov on 08.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

class CountryCell: UITableViewCell {
    
    // MARK: - Properties
    
    private let nameCountryLabel = UILabel()
    private let numberStatusLabel = UILabel()
    private let incStatusLabel = UILabel()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Colors.black
        
        nameCountryLabel.textColor = Colors.white
        
        numberStatusLabel.font = .systemFont(ofSize: 15, weight: .medium)
        incStatusLabel.font = .systemFont(ofSize: 15, weight: .medium)
        
        configureStack()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configurations
    
    private func configureStack() {
        
        let numberAndIncConfirmedStack = configureNumberAndIncStack()
        
        
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.addArrangedSubview(nameCountryLabel)
        stack.addArrangedSubview(numberAndIncConfirmedStack)
        
        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            stack.topAnchor.constraint(equalTo: topAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func configureNumberAndIncStack() -> UIStackView{
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .trailing
        stack.addArrangedSubview(numberStatusLabel)
        stack.addArrangedSubview(incStatusLabel)
        return stack
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
