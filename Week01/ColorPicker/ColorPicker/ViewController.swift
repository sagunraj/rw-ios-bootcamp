//
//  ViewController.swift
//  ColorPicker
//
//  Created by kshitij on 5/28/20.
//  Copyright © 2020 Sagun Raj Lage. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak private var colorLabel: UILabel!
    
    @IBOutlet var sliders: [UISlider]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        colorLabel.text = ""
    }
    
}

// MARK: - Actions
extension ViewController {
    
    @IBAction func onResetTap(_ sender: UIButton) {
    }
    
    @IBAction func onSetColorTap(_ sender: UIButton) {
    }
    
    @IBAction func onSliderChange(_ sender: UISlider) {
        if sender.tag == 0 {
            print("0")
        } else if sender.tag == 1 {
            print("1")
        } else {
            print("2")
        }
    }
    
}

