//
//  ViewController.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var soundButton: UIButton!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var clueLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var clues: [Clue] = []
    var correctAnswerClue: Clue?
    var points: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        getClues()
        
        self.scoreLabel.text = "\(self.points)"
        
        if SoundManager.shared.isSoundEnabled == false {
            soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
        } else {
            soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
        }
        
        SoundManager.shared.playSound()
    }
    
    private func getClues() {
        Networking.sharedInstance.getRandomCategory(completion: { (categoryId, message) in
            guard let id = categoryId else {
                DispatchQueue.main.async {
                    self.showOkAlert(withTitle: "Error",
                                     andMessage: message)
                }
                return
            }
            Networking.sharedInstance.getAllCluesInCategory(with: id) { (clues, message) in
                guard let clues = clues else {
                    DispatchQueue.main.async {
                        self.showOkAlert(withTitle: "Error",
                                         andMessage: message)
                    }
                    return
                }
                self.correctAnswerClue = clues[0]
                var cluesArray = [self.correctAnswerClue!]
                let otherClues = clues.filter { (clue) -> Bool in
                    clue.answer != self.correctAnswerClue?.answer
                }.prefix(3)
                cluesArray.append(contentsOf: otherClues)
                self.clues = cluesArray.shuffled()
                DispatchQueue.main.async {
                    self.setUpView()
                }
            }
        })
    }
    
    private func setUpView() {
        self.categoryLabel.text = self.clues[0].category.title
        self.clueLabel.text = self.clues[0].question
        self.tableView.reloadData()
    }
    
    @IBAction func didPressVolumeButton(_ sender: Any) {
        SoundManager.shared.toggleSoundPreference()
        if SoundManager.shared.isSoundEnabled == false {
            soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
        } else {
            soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
        }
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clues.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ClueTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? ClueTableViewCell else {
            return UITableViewCell()
        }
        cell.setupClueTitle(with: clues[indexPath.row].answer)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if clues[indexPath.row].answer == correctAnswerClue?.answer {
            points += 100
            scoreLabel.text = "\(points)"
        }
        getClues()
    }
}

