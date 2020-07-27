//
//  ViewController.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak private var logoImageView: UIImageView!
    @IBOutlet weak private var soundButton: UIButton!
    @IBOutlet weak private var categoryLabel: UILabel!
    @IBOutlet weak private var clueLabel: UILabel!
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var scoreLabel: UILabel!
    
    private let viewModel = ClueViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        viewModel.getClues()
        
        scoreLabel.text = "\(viewModel.points)"
        
        if SoundManager.shared.isSoundEnabled == false {
            soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
        } else {
            soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
        }
        
        SoundManager.shared.playSound()
    }
    
    private func setUpView() {
        self.categoryLabel.text = self.viewModel.clues[0].category.title
        self.clueLabel.text = self.viewModel.clues[0].question
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

// MARK: - ClueViewModelDelegate
extension ViewController: ClueViewModelDelegate {
    
    func didMeetError(with message: String) {
        DispatchQueue.main.async {
            self.showOkAlert(withTitle: "Error", andMessage: message)
        }
    }
    
    func didFetchClues() {
        DispatchQueue.main.async {
            self.setUpView()
        }
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.clues.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ClueTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? ClueTableViewCell else {
            return UITableViewCell()
        }
        cell.setupClueTitle(with: viewModel.clues[indexPath.row].answer)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.clues[indexPath.row].answer == viewModel.correctAnswerClue?.answer {
            viewModel.points += 100
            scoreLabel.text = "\(viewModel.points)"
        }
        viewModel.getClues()
    }
    
}

