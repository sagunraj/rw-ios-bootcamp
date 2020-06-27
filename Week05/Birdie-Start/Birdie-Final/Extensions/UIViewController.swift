//
//  UIViewController.swift
//  Birdie-Final
//
//  Created by Sagun Raj Lage on 6/27/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertWithOk(with title: String = "Birdie",
                         and message: String = "") {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { (action) in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
