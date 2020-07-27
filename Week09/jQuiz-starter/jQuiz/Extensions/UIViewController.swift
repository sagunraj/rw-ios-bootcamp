//
//  UIViewController.swift
//  jQuiz
//
//  Created by Sagun Raj Lage on 7/27/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showOkAlert(withTitle title: String,
                   andMessage message: String,
                   andOkTitle okTitle: String = "OK",
                   okHandler: @escaping (() -> Void) = {}) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: okTitle, style: .default, handler: {
            action in
            okHandler()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
