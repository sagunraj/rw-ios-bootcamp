//
//  UIView.swift
//  FlappyBird
//
//  Created by Sagun Raj Lage on 8/10/20.
//  Copyright © 2020 Sagun Raj Lage. All rights reserved.
//

import UIKit

extension UIView {
    
    func loadViewFromNib(with nibName: String) -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
}
