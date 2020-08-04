//
//  UserDataProtocol.swift
//  Covid
//
//  Created by Kirill Selivanov on 04.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

protocol UserDataProtocol {
    
    func addData(country: String)
    
    func getData() -> String?

}
