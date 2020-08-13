//
//  Integer.swift
//  Covid
//
//  Created by Kirill Selivanov on 17.07.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

extension Int {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
    
    var round: Int {
        var p = 1
        for _ in 1...18 {
            p *= 10
            if p > self {
                return p
            }
        }
        return 9223372036854775807
    }
}
