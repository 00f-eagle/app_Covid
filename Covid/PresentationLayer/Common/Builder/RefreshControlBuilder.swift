//
//  RefreshControlBuilder.swift
//  Covid
//
//  Created by Kirill Selivanov on 26.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

struct RefreshControlBuilder {
    
    static func createRefreshControl(action: Selector) -> UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: action, for: .valueChanged)
        refreshControl.tintColor = Colors.black
        return refreshControl
    }

}
