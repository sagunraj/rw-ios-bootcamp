//
//  ViewController.swift
//  RevBullsEye
//
//  Created by Sagun Raj Lage on 6/7/20.
//  Copyright © 2020 Sagun Raj Lage. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak private var slider: UISlider!
    @IBOutlet weak private var targetTextField: UITextField!
    @IBOutlet weak private var roundLabel: UILabel!
    @IBOutlet weak private var scoreLabel: UILabel!
    @IBOutlet weak private var hintSwitch: UISwitch!
    @IBOutlet weak private var hitMeButton: UIButton!
    
    private let game = BullsEyeGame()
    
    private var quickDiff: Int {
        return abs(game.getTargetValue() - game.getCurrentValue())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        startNewGame()
        setupMinimumTrackTintColor()
    }
    
    private func setupMinimumTrackTintColor() {
        slider.minimumTrackTintColor = hintSwitch.isOn ? UIColor.blue.withAlphaComponent(CGFloat(quickDiff)/100.0) : .systemBlue
    }
    
    private func setupView() {
        targetTextField.keyboardType = .numberPad
        targetTextField.addTarget(self,
                                  action: #selector(didChangeText(_:)),
                                  for: .editingChanged)
        slider.maximumValue = 100
        slider.minimumValue = 1
        slider.value = 50
        hitMeButton.isEnabled = false
    }
    
    @objc func didChangeText(_ sender: UITextField) {
        hintSwitch.setOn(false, animated: true)
        setupMinimumTrackTintColor()
        guard let text = sender.text,
            let number = Int(text),
            1...100 ~= number else {
                hitMeButton.isEnabled = false
                return
        }
        hitMeButton.isEnabled = true
        game.setTargetValue(with: number)
    }
    
    private func startNewRound() {
        game.setupNewRound()
        targetTextField.text = ""
        slider.value = 50
        updateLabels()
    }
    
    private func updateLabels() {
        scoreLabel.text = "Score: \(game.getScore())"
        roundLabel.text = "Round:  \(game.getRound())"
        setupMinimumTrackTintColor()
    }
    
    private func startNewGame() {
        game.resetGame()
        startNewRound()
    }
    
}

// MARK: - Actions
extension ViewController {
    
    @IBAction func onSliderMovement(_ sender: UISlider) {
        game.setCurrentValue(with: Int(sender.value))
        setupMinimumTrackTintColor()
    }
    
    @IBAction func onSwitchChange(_ sender: UISwitch) {
        setupMinimumTrackTintColor()
    }
    
    @IBAction func onResetTap(_ sender: UIButton) {
        setupSwitchAndButton()
        startNewGame()
    }
    
    private func setupSwitchAndButton() {
        hintSwitch.setOn(false, animated: true)
        hitMeButton.isEnabled = false
        setupMinimumTrackTintColor()
    }
    
    @IBAction func onHitMeTap(_ sender: UIButton) {
        game.setCurrentValue(with: Int(slider.value))
        let (points, title) = game.getCalculatedPointsAndTitle()
        let message = "You scored \(points) points"
        showOkAlert(withTitle: title, andMessage: message) { [weak self] in
            guard let self = self else { return }
            self.setupSwitchAndButton()
            self.startNewRound()
        }
    }
    
}

