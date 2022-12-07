//
//  DragonRadarViewModel.swift
//  DragonBall
//
//  Created by Rafael Almeida on 12/6/22.
//

import Foundation

class DragonRadarViewModel: ObservableObject {
    var dragonBalls = [DragonBall]()
    
    init() {        
        dragonBalls.append(DragonBall(positionX: 70, positionY: 300))
        dragonBalls.append(DragonBall(positionX: -100, positionY: 70))
        dragonBalls.append(DragonBall(positionX: 100, positionY: -60))
    }
}
