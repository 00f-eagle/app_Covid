//
//  ActivityIndicatorBuilder.swift
//  Covid
//
//  Created by Kirill Selivanov on 21.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

struct ActivityIndicatorBuilder {
    
    static func configureActivityIndicator(indicator: UIActivityIndicatorView, view: UIView) {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.style = .gray
        view.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}
