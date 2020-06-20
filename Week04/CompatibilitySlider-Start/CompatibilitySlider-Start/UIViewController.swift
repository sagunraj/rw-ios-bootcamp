//
//  UIViewController.swift
//  CompatibilitySlider-Start
//
//  Created by Sagun Raj Lage on 6/20/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlertWithOk(with title: String = "Compatibility Slider",
                         and message: String = "",
                         okHandler: @escaping () -> Void = {}) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            okHandler()
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
