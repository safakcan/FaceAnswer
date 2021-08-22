//
//  Sounds.swift
//  FaceAnswer
//
//  Created by Şafak Can Baş on 22.08.2021.
//

import Foundation
import  AVFoundation

class Sounds {
    static var shared = Sounds()
    
    let correctAnswerSound = URL(fileURLWithPath: Bundle.main.path(forResource: "correct", ofType: "mp3") ?? "")
    let wrongAnswerSound = URL(fileURLWithPath: Bundle.main.path(forResource: "wrong", ofType: "mp3") ?? "")
    var audioPlayer = AVAudioPlayer()
    
    
    func playSound(with sound: URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: sound)
            audioPlayer.play()
        } catch  {
            print("no sound!!")
        }
    }
    
}
