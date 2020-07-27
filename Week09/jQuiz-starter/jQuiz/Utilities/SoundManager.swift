//
//  SoundManager.swift
//  jQuiz
//
//  Created by Jay Strawn on 7/17/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

//import Foundation
import AVFoundation

class SoundManager: NSObject {

    static let shared = SoundManager()

    private var player: AVAudioPlayer?
    
    var isSoundOn: Bool {
        UserDefaults.standard.bool(forKey: "sound")
    }
    
    func playOrStopSound() {
        if isSoundOn {
            guard let filePathString = Bundle.main.path(forResource: "Jeopardy-theme-song",
                                                        ofType: "mp3"),
                let filePath = URL(string: filePathString) else { return }
            do {
                player = try AVAudioPlayer(contentsOf: filePath)
                player?.play()
            } catch {
                print("\(error.localizedDescription)")
            }
        } else {
            player = nil
        }
    }
    
    func toggleSoundPreference() {
        UserDefaults.standard.set(!isSoundOn, forKey: "sound")
        playOrStopSound()
    }

}
