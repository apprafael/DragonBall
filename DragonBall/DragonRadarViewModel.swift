//
//  DragonRadarViewModel.swift
//  DragonBall
//
//  Created by Rafael Almeida on 12/6/22.
//

import Foundation
import CoreLocation
import AVKit

protocol DragonRadarPresentationLogic {
    func directionChanged(angle: Double)
    func displayDragonBalls(dragonBalls: [DragonBall])
}

class DragonRadarViewModel: ObservableObject {
    private var audioPlayer: AVAudioPlayer!
    @Published var magneticHeading: CLLocationDirection
    @Published var dragonBalls = [DragonBall]()
    
    init() {
        self.magneticHeading = CLLocationDirection()
    }

    private func startBipSound() {
        guard let sound = Bundle.main.path(forResource: "bip", ofType: "mp3") else { return }
        self.audioPlayer = try? AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
        self.audioPlayer.numberOfLoops = -1
        self.audioPlayer.play()
    }
}

extension DragonRadarViewModel: DragonRadarPresentationLogic {
    func displayDragonBalls(dragonBalls: [DragonBall]) {
        self.dragonBalls = dragonBalls
        startBipSound()
    }
    
    func directionChanged(angle: Double) {
        magneticHeading = angle
    }
}
