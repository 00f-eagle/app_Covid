//
//  ProgressViewBuilder.swift
//  Covid
//
//  Created by Kirill Selivanov on 25.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

struct ProgressViewBuilder {
    
    static func configureProgressView(progressView: UIProgressView, view: UIView) {
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.setProgress(0, animated: false)
        progressView.trackTintColor = Colors.gray
        progressView.progressTintColor = Colors.black
        progressView.layer.masksToBounds = true
        progressView.layer.cornerRadius = 8
        view.addSubview(progressView)
        NSLayoutConstraint.activate([
            progressView.widthAnchor.constraint(equalToConstant: 200),
            progressView.heightAnchor.constraint(equalToConstant: 5),
            progressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
