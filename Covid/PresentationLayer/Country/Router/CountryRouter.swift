//
//  CountryRouter.swift
//  Covid
//
//  Created by Kirill Selivanov on 02.08.2020.
//  Copyright © 2020 Kirill Selivanov. All rights reserved.
//

import UIKit

final class CountryRouter {
    
    // MARK: - Properties
    
    weak var view: CountryView!
}


// MARK: - CountryRouterInput
extension CountryRouter: CountryRouterInput {
    func dismissView() {
        view.dismiss(animated: false, completion: nil)
    }
    
    func presentFailureAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
}
