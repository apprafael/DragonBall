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
    var distance: Int
    var direction: Double
    let distanceRange =  -0.029999999999999...0.029999999999999
    let directionRange = 0.0...360.0
    
    init(userLocation: CLLocation) {
        let dragonBallLat = userLocation.coordinate.latitude + Double.random(in: distanceRange)
        let dragonBallLong = userLocation.coordinate.longitude + Double.random(in: distanceRange)
        location = CLLocation(latitude: dragonBallLat, longitude: dragonBallLong)
        distance = Int(location.distance(from: userLocation)/10)
        direction = Double.random(in: directionRange)
    }
}
