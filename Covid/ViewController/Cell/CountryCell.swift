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
    
    private var nameCountry = UILabel()
    private var numberStatus = UILabel()
    private var numberNewStatus = UILabel()
    private var stack = UIStackView()
    var countryModel: CountryCellModel? {
        didSet {
            if let countryModel = countryModel {
                updateContent(with: countryModel)
            }
        }
    }
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameCountry.translatesAutoresizingMaskIntoConstraints = false
        addSubview(nameCountry)
        numberStatus.translatesAutoresizingMaskIntoConstraints = false
        addSubview(numberStatus)
        numberNewStatus.translatesAutoresizingMaskIntoConstraints = false
        addSubview(numberNewStatus)
        setupNSLayoutConstraint()
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configurations
    
    private func updateContent(with countryModel: CountryCellModel) {
        nameCountry.text = countryModel.country
        //numberStatus.text = String(countryModel.totalStatus)
        //numberNewStatus.text = String(countryModel.newStatus)
    }
    
    private func setupNSLayoutConstraint() {
        NSLayoutConstraint.activate([
        nameCountry.leadingAnchor.constraint(equalTo: leadingAnchor),
        nameCountry.trailingAnchor.constraint(equalTo: trailingAnchor),
        nameCountry.topAnchor.constraint(equalTo: topAnchor),
        nameCountry.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
