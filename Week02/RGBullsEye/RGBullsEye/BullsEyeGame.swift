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

import Foundation

class BullsEyeGame {
    
    private var currentValue = RGB()
    private var targetValue = RGB()
    private var score = 0
    private var round = 0
    
    func getCalculatedPointsAndTitle() -> (points: Int, title: String) {
        let difference = currentValue.difference(target: targetValue)
        var points = Int(100 - difference * 100)
        let title: String
        if difference == 0 {
            title = "Perfect!"
            points += 100
        } else if difference < 5 {
            title = "You almost had it!"
            if difference == 1 {
                points += 50
            }
        } else if difference < 10 {
            title = "Pretty good!"
        } else {
            title = "Not even close..."
        }
        score += points

        return (points: points, title: title)
    }
    
    func resetGame() {
        score = 0
        round = 0
    }
    
    func setupNewRound() {
        round += 1
        targetValue = RGB(r: Int.random(in: 0...255),
                          g: Int.random(in: 0...255),
                          b: Int.random(in: 0...255))
        currentValue = RGB()
    }
    
    func getCurrentValue() -> RGB { currentValue }
    
    func getTargetValue() -> RGB { targetValue }
    
    func getScore() -> Int { score }
    
    func getRound() -> Int { round }
    
    func setCurrentValue(with value: RGB) {
        self.currentValue = value
    }
    
    func setTargetValue(with value: RGB) {
        self.targetValue = value
    }
    
    func setScore(with value: Int) {
        self.score = value
    }
    
    func setRound(with value: Int) {
        self.round = value
    }
    
}
