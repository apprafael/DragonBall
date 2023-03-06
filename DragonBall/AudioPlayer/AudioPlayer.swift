//
//  AudioPlayer.swift
//  DragonBall
//
//  Created by Rafael Almeida on 06/03/23.
//

import AVFoundation

class AudioPlayer {
    var player: AVAudioPlayer?

    func playAudioRepeatedly(filename: String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "mp3") else {
            print("Error: Could not find audio file.")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.numberOfLoops = -1 // Set number of loops to -1 to play the audio file repeatedly
            player?.prepareToPlay()
            player?.play()
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
    }
}
