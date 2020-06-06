//
//  ViewController.swift
//  BullsEye
//
//  Created by Ray Wenderlich on 6/13/18.
//  Copyright © 2018 Ray Wenderlich. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak private var slider: UISlider!
    @IBOutlet weak private var targetLabel: UILabel!
    @IBOutlet weak private var scoreLabel: UILabel!
    @IBOutlet weak private var roundLabel: UILabel!
    
    private let bullsEyeGame = BullsEyeGame()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let roundedValue = slider.value.rounded()
        bullsEyeGame.setCurrentValue(with: Int(roundedValue))
        startNewGame()
    }
    
    func startNewRound() {
        bullsEyeGame.setupNewRound()
        slider.value = Float(bullsEyeGame.getCurrentValue())
        updateLabels()
    }
    
    func updateLabels() {
        targetLabel.text = String(bullsEyeGame.getTargetValue())
        scoreLabel.text = String(bullsEyeGame.getScore())
        roundLabel.text = String(bullsEyeGame.getRound())
    }
    
}

// MARK: - Actions
extension ViewController {
    
    @IBAction func startNewGame() {
        bullsEyeGame.resetGame()
        startNewRound()
    }
    
    @IBAction func sliderMoved(_ slider: UISlider) {
        let roundedValue = slider.value.rounded()
        print(roundedValue)
        bullsEyeGame.setCurrentValue(with: Int(roundedValue))
    }
    
    @IBAction func showAlert() {
        let (points, title) = bullsEyeGame.getCalculatedPointsAndTitle()
        
        let message = "You scored \(points) points"
        
        showOkAlert(withTitle: title, andMessage: message) {
            self.startNewRound()
        }
    }
    
}



