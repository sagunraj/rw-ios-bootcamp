//
//  ViewController.swift
//  FlappyBird
//
//  Created by Ashwin Shrestha on 8/10/20.
//  Copyright © 2020 Sagun Raj Lage. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak private var enlargeButtonTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak private var colorButtonLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak private var jumpButtonBottomConstraint: NSLayoutConstraint!
    
    private var shouldButtonsSpread = false {
        didSet {
            setupButtonsAnimation(with: shouldButtonsSpread ? 30 : -50)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupButtonsAnimation(with constraint: CGFloat) {
        enlargeButtonTrailingConstraint.constant = constraint
        colorButtonLeadingConstraint.constant = constraint
        jumpButtonBottomConstraint.constant = constraint
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
}

// MARK: - Actions
extension ViewController {
    
    @IBAction func onPlayButtonTap(_ sender: UIButton) {
        shouldButtonsSpread.toggle()
    }
    
}

