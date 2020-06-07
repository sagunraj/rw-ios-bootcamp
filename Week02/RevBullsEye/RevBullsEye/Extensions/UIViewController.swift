//
//  UIViewController.swift
//  RevBullsEye
//
//  Created by Sagun Raj Lage on 6/7/20.
//  Copyright © 2020 Sagun Raj Lage. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showOkAlert(withTitle title: String,
                   andMessage message: String,
                   okHandler: @escaping () -> Void) {
        
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: {
            action in
            okHandler()
        })
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}
