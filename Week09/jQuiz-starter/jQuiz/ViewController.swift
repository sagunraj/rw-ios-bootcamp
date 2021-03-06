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
    @IBOutlet weak private var stopButton: UIButton!
    @IBOutlet weak private var scoreLabel: UILabel!
    
    private let viewModel = ClueViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupTableView()
        setupLabels()
        setupSoundIcon()
        SoundManager.shared.playOrStopSound()
        setupStopButton()
    }
    
    private func setupStopButton() {
        stopButton.titleLabel?.font = Fonts.Regular.r3
        stopButton.tintColor = .white
    }
    
    private func setupLabels() {
        scoreLabel.font = Fonts.Bold.b1
        categoryLabel.font = Fonts.Medium.m1
        clueLabel.font = Fonts.Medium.m2
    }
    
    private func setupViewModel() {
        viewModel.delegate = self
        viewModel.getClues()
        //        viewModel.fetchLogoImage()
        if let url = URL(string: "https://cdn1.edgedatg.com/aws/v2/abc/ABCUpdates/blog/2900129/8484c3386d4378d7c826e3f3690b481b/1600x900-Q90_8484c3386d4378d7c826e3f3690b481b.jpg") {
            UIImageView.setImage(url) { (image) in
                DispatchQueue.main.async {
                    self.logoImageView.image = image
                }
            }
        }
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    private func setUpView() {
        scoreLabel.text = "\(viewModel.points)"
        categoryLabel.text = self.viewModel.clues[0].category.title
        clueLabel.text = self.viewModel.clues[0].question
        tableView.reloadData()
    }
    
    private func setupSoundIcon() {
        if SoundManager.shared.isSoundOn {
            soundButton.setImage(UIImage(systemName: "speaker"), for: .normal)
        } else {
            soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
        }
    }
    
}

// MARK: - Actions
extension ViewController {
    
    @IBAction func onStopTap(_ sender: UIButton) {
        showOkAlert(withTitle: viewModel.points == 0 ? "Sorry!" : "Congratulations!", andMessage: "Your score is: \(viewModel.points)") {
            self.viewModel.points = 0
            self.viewModel.getClues()
        }
    }
    
    @IBAction func didPressVolumeButton(_ sender: Any) {
        SoundManager.shared.toggleSoundPreference()
        setupSoundIcon()
    }
    
}

// MARK: - ClueViewModelDelegate
extension ViewController: ClueViewModelDelegate {
    
//    func didFetchLogo(with image: UIImage) {
//        DispatchQueue.main.async {
//            self.logoImageView.image = image
//        }
//    }
    
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
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: ClueTableViewCell.reuseIdentifier,
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

