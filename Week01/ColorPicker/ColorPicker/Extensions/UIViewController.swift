//
//  UIViewController.swift
//  ColorPicker
//
//  Created by Sagun Raj Lage on 5/28/20.
//  Copyright © 2020 Sagun Raj Lage. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertWithOk(with title: String = "ColorPicker",
                         and message: String = "") {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { (action) in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}

