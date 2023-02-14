//
//  DragonBall.swift
//  DragonBall
//
//  Created by Rafael Almeida on 12/6/22.
//

import Foundation
import CoreLocation

class DragonBall: Identifiable, ObservableObject {
    let id = UUID()
    let location: CLLocation
    @Published var distance: Int
    @Published var direction: Double
    private let distanceRange =  -0.003999999999999...0.003999999999999
    private let directionRange = 0.0...360.0
    
    init(userLocation: CLLocation) {
        let dragonBallLat = userLocation.coordinate.latitude + Double.random(in: distanceRange)
        let dragonBallLong = userLocation.coordinate.longitude + Double.random(in: distanceRange)
        location = CLLocation(latitude: dragonBallLat, longitude: dragonBallLong)
        distance = Int(location.distance(from: userLocation))
        direction = Double()
        direction = getBearingBetweenTwoPoints1(point1: userLocation, point2: location)
    }

    private func degreesToRadians(degrees: Double) -> Double {
        degrees * .pi / 180.0
    }

    private func radiansToDegrees(radians: Double) -> Double {
        radians * 180.0 / .pi
    }

    private func getBearingBetweenTwoPoints1(point1 : CLLocation, point2 : CLLocation) -> Double {

        let lat1 = degreesToRadians(degrees: point1.coordinate.latitude)
        let lon1 = degreesToRadians(degrees: point1.coordinate.longitude)

        let lat2 = degreesToRadians(degrees: point2.coordinate.latitude)
        let lon2 = degreesToRadians(degrees: point2.coordinate.longitude)

        let dLon = lon2 - lon1

        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)
        let radiansBearing = atan2(y, x)

        return radiansToDegrees(radians: radiansBearing)
    }

    private func updateDirection(userLocation: CLLocation) {
        direction = getBearingBetweenTwoPoints1(point1: location, point2: userLocation)
    }

    func locationChanged(userLocation: CLLocation) {
        distance = Int(location.distance(from: userLocation))
        updateDirection(userLocation: userLocation)
    }
}
