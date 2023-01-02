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
    func viewDidInit()
    func directionChanged(angle: Double)
    func distanceChanged(distance: CGFloat)
}

class DragonRadarViewModel: ObservableObject {
    private var interactor: DragonBallRadarBussinessLogic
    private var audioPlayer: AVAudioPlayer!
    @Published var magneticHeading: CLLocationDirection
    @Published var dragonBalls = [DragonBall]()
    
    init(interactor: DragonBallRadarBussinessLogic) {
        self.interactor = interactor
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
    func directionChanged(angle: Double) {
        magneticHeading = angle
    }
    
    func distanceChanged(distance: CGFloat) {
        dragonBalls = dragonBalls.compactMap { dragonBall in
            var dragonBall = dragonBall
            dragonBall.distance = Int(distance)
            return dragonBall
        }
    }
    
    func viewDidInit() {
        interactor.createAndTrackingDragonBalls()
        startBipSound()
    }
}
