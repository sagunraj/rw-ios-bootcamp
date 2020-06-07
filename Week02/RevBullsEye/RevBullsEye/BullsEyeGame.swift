//
//  BullsEyeGame.swift
//  RevBullsEye
//
//  Created by Sagun Raj Lage on 6/7/20.
//  Copyright © 2020 Sagun Raj Lage. All rights reserved.
//

import Foundation

final class BullsEyeGame {
    
    private var currentValue = 0
    private var targetValue = 0
    private var score = 0
    private var round = 0
    
    func getCalculatedPointsAndTitle() -> (points: Int, title: String) {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
                
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
        targetValue = 1
        currentValue = 50
    }
    
    func getCurrentValue() -> Int { currentValue }
    
    func getTargetValue() -> Int { targetValue }
    
    func getScore() -> Int { score }
    
    func getRound() -> Int { round }
    
    func setCurrentValue(with value: Int) {
        self.currentValue = value
    }
    
    func setTargetValue(with value: Int) {
        self.targetValue = value
    }
    
    func setScore(with value: Int) {
        self.score = value
    }
    
    func setRound(with value: Int) {
        self.round = value
    }
    
}
