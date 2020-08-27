//
//  StackView.swift
//  Covid
//
//  Created by Kirill Selivanov on 11.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

extension UIStackView {
    func addBackground(color: UIColor, cornerRadius: CGFloat) {
        let subView = UIView()
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        subView.backgroundColor = color
        subView.layer.cornerRadius = cornerRadius
        insertSubview(subView, at: 0)
    }
}
