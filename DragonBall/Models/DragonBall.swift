//
//  DragonBall.swift
//  DragonBall
//
//  Created by Rafael Almeida on 12/6/22.
//

import Foundation
import CoreLocation

struct DragonBall: Identifiable {
    let id = UUID()
    let location: CLLocation
    var positionY: Int
    var degree: Double
}
