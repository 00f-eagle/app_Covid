//
//  StackView.swift
//  Covid
//
//  Created by Kirill Selivanov on 11.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView()
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}
