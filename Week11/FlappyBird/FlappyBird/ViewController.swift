//
//  ViewController.swift
//  FlappyBird
//
//  Created by Sagun Raj Lage on 8/10/20.
//  Copyright © 2020 Sagun Raj Lage. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak private var backgroundImageView: UIImageView!
    @IBOutlet weak private var enlargeButtonTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak private var colorButtonLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak private var jumpButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak private var logoHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak private var playButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak private var birdImageView: UIImageView!
    @IBOutlet weak private var birdImageViewBottomConstraint: NSLayoutConstraint!
    
    private var shouldButtonsSpread = false {
        didSet {
            setupButtonsAnimation(with: shouldButtonsSpread ? 30 : -50)
        }
    }
    
    private var animationProperties: [String: Bool] = ["enlarge": false,
                                                       "jump": false,
                                                       "color": false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateLogoAndPlayButton()
    }
    
    private func animateLogoAndPlayButton() {
        self.logoHeightConstraint.constant = 128
        UIView.animate(withDuration: 0.25, delay: 0.5, options: [.curveEaseInOut], animations: {
            self.view.layoutIfNeeded()
        })
        
        self.playButtonBottomConstraint.constant = 30
        UIView.animate(withDuration: 0.25, delay: 0.5, options: [.curveEaseInOut], animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    private func setupButtonsAnimation(with constraint: CGFloat) {
        enlargeButtonTrailingConstraint.constant = constraint
        colorButtonLeadingConstraint.constant = constraint
        jumpButtonBottomConstraint.constant = constraint
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
}

// MARK: - Actions
extension ViewController {
    
    @IBAction func onColorButtonTap(_ sender: UIButton) {
        animationProperties["color"]?.toggle()
    }
    
    @IBAction func onJumpButtonTap(_ sender: UIButton) {
        animationProperties["jump"]?.toggle()
    }
    
    @IBAction func onEnlargeButtonTap(_ sender: UIButton) {
        animationProperties["enlarge"]?.toggle()
    }
    
    @IBAction func onPlayButtonTap(_ sender: UIButton) {
        shouldButtonsSpread.toggle()
        if !shouldButtonsSpread {
            colorBirdAndChangeBackground()
            if animationProperties["enlarge"]! {
                scaleUpBirdImage()
            }
            if self.animationProperties["jump"]! {
                self.makeBirdJump()
            }
        }
    }
    
    private func scaleUpBirdImage() {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       options: .curveEaseInOut,
                       animations: {
            self.birdImageView.transform = CGAffineTransform(scaleX: 2, y: 2)
        }) { _ in
            self.animationProperties["enlarge"]?.toggle()
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: .curveEaseInOut,
                           animations: {
                self.birdImageView.transform = .identity
            })
        }
    }
    
    private func colorBirdAndChangeBackground() {
        if animationProperties["color"]! {
            UIView.animate(withDuration: 0.25, delay: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.birdImageView.image = #imageLiteral(resourceName: "yellowbird-upflap.png")
                            self.backgroundImageView.image = #imageLiteral(resourceName: "background-night.png")
                            self.view.layoutIfNeeded()
            })
        } else {
            UIView.animate(withDuration: 0.25, delay: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.birdImageView.image = #imageLiteral(resourceName: "bluebird-upflap.png")
                            self.backgroundImageView.image = #imageLiteral(resourceName: "background-day.png")
                            self.view.layoutIfNeeded()
            })
        }
    }
    
    private func makeBirdJump() {
        UIView.animateKeyframes(withDuration: 1,
                                delay: 0,
                                options: .calculationModeCubic,
                                animations: {
            self.birdImageViewBottomConstraint.constant = 200
            UIView.addKeyframe(withRelativeStartTime: 0,
                               relativeDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
            self.birdImageViewBottomConstraint.constant = 0
            UIView.addKeyframe(withRelativeStartTime: 0.3,
                               relativeDuration: 0.7) {
                self.view.layoutIfNeeded()
            }
        }) { _ in
            self.animationProperties["jump"]?.toggle()
        }
    }
    
}

