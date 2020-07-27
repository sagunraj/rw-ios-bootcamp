//
//  ClueViewModel.swift
//  jQuiz
//
//  Created by Sagun Raj Lage on 7/27/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

protocol ClueViewModelDelegate: class {
    func didMeetError(with message: String)
    func didFetchClues()
    func didFetchLogo(with image: UIImage)
}

class ClueViewModel {
    
    var clues: [Clue] = []
    var correctAnswerClue: Clue?
    var points: Int = 0
    
    weak var delegate: ClueViewModelDelegate?
    
    func getClues() {
        Networking.sharedInstance.getRandomCategory(completion: { (categoryId, message) in
            guard let id = categoryId else {
                self.delegate?.didMeetError(with: message)
                return
            }
            Networking.sharedInstance.getAllCluesInCategory(with: id) { (clues, message) in
                guard let clues = clues else {
                    self.delegate?.didMeetError(with: message)
                    return
                }
                self.correctAnswerClue = clues[0]
                var cluesArray = [self.correctAnswerClue!]
                let otherClues = clues.filter { (clue) -> Bool in
                    clue.answer != self.correctAnswerClue?.answer
                }.prefix(3)
                cluesArray.append(contentsOf: otherClues)
                self.clues = cluesArray.shuffled()
                self.delegate?.didFetchClues()
            }
        })
    }
    
    func fetchLogoImage() {
        Networking.sharedInstance.getLogoImage { (image, message) in
            guard let image = image else {
                self.delegate?.didMeetError(with: message)
                return
            }
            self.delegate?.didFetchLogo(with: image)
        }
    }
    
}
