/*
 * Copyright (c) 2015 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var targetTextLabel: UILabel!
    @IBOutlet weak var guessLabel: UILabel!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    let game = BullsEyeGame()
    
    var quickDiff: [String: Int] {
        return ["red": abs(game.getTargetValue().r - game.getCurrentValue().r),
                "green": abs(game.getTargetValue().g - game.getCurrentValue().g),
                "blue": abs(game.getTargetValue().b - game.getCurrentValue().b)]
    }

    
    private func setupGuessView() {
        let roundedValue = game.getCurrentValue()
        guessLabel.backgroundColor = UIColor(rgbStruct: roundedValue)
        redLabel.text = "R \(roundedValue.r)"
        greenLabel.text = "G \(roundedValue.g)"
        blueLabel.text = "B \(roundedValue.b)"
    }
    
    @IBAction func aSliderMoved(sender: UISlider) {
        let roundedValue = RGB(r: Int(redSlider.value.rounded()),
                               g: Int(greenSlider.value.rounded()),
                               b: Int(blueSlider.value.rounded()))
        game.setCurrentValue(with: roundedValue)
        setupGuessView()
        setupMinimumTrackTintColor()
    }
    
    private func setupMinimumTrackTintColor() {
        redSlider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(CGFloat(quickDiff["red"]!)/100.0)
        greenSlider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(CGFloat(quickDiff["green"]!)/100.0)
        blueSlider.minimumTrackTintColor = UIColor.blue.withAlphaComponent(CGFloat(quickDiff["blue"]!)/100.0)
    }
    
    @IBAction func showAlert(sender: AnyObject) {
        let (points, title) = game.getCalculatedPointsAndTitle()
        
        let message = "You scored \(points) points"
        
        showOkAlert(withTitle: title, andMessage: message) {
            self.startNewRound()
        }
    }
    
    @IBAction func startOver(sender: AnyObject) {
        startGameOver()
    }
    
    private func startGameOver() {
        game.resetGame()
        startNewRound()
    }
    
    func startNewRound() {
        game.setupNewRound()
        updateView()
    }
    
    func updateView() {
        scoreLabel.text = "Score: \(game.getScore())"
        roundLabel.text = "Round: \(game.getRound())"
        let currentValue = game.getCurrentValue()
        redSlider.value = Float(currentValue.r)
        greenSlider.value = Float(currentValue.g)
        blueSlider.value = Float(currentValue.b)
        setupGuessView()
        targetLabel.backgroundColor = UIColor(rgbStruct: game.getTargetValue())
        setupMinimumTrackTintColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGuessView()
        startGameOver()
        setupMinimumTrackTintColor()
    }
}

