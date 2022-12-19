//
//  DragonRadarViewModel.swift
//  DragonBall
//
//  Created by Rafael Almeida on 12/6/22.
//

import Foundation
import CoreLocation

class DragonRadarViewModel: NSObject, ObservableObject {
    private var locationManager: CLLocationManager?
    @Published var dragonBalls = [DragonBall]()
    
    override init() {
        super.init()
        setupLocationManager()
        locationManager?.startUpdatingLocation()
        setupDragonBalls(userLocation: locationManager?.location)
        locationManager?.startUpdatingHeading()
    }

//    private func updateDragonsBalls(direction: CLLocationDirection) {
//        for index in dragonBalls.indices {
//            dragonBalls[index].direction = direction
//        }
//    }

    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.delegate = self
    }

    func setupDragonBalls(userLocation: CLLocation?) {
        guard let userLocation = userLocation else { return }
        for _ in 1...6 {
            let dragonBallLat = userLocation.coordinate.latitude + Double.random(in: -0.029999999999999...0.029999999999999)
            let dragonBallLong = userLocation.coordinate.longitude + Double.random(in: -0.029999999999999...0.029999999999999)
            let dragonBallLocation = CLLocation(latitude: dragonBallLat, longitude: dragonBallLong)
            let distance = Int(dragonBallLocation.distance(from: userLocation)/10)
            dragonBalls.append(DragonBall(location: dragonBallLocation, distance: distance, direction: 0))
        }
    }

    private func updateDragonBallsDistance(userLocation: CLLocation) {
        for (index, dragonBall) in dragonBalls.enumerated() {
            let distance = Int(dragonBall.location.distance(from: userLocation)/10)
            dragonBalls[index].distance = distance
            dragonBalls[index].direction = getBearingBetweenTwoPoints1(point1: userLocation, point2: dragonBall.location)
        }
    }

    func degreesToRadians(degrees: Double) -> Double { return degrees * .pi / 180.0 }
    func radiansToDegrees(radians: Double) -> Double { return radians * 180.0 / .pi }

    func getBearingBetweenTwoPoints1(point1 : CLLocation, point2 : CLLocation) -> Double {

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
}

extension DragonRadarViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        //updateDragonsBalls(direction: newHeading.magneticHeading)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = manager.location else { return }
        updateDragonBallsDistance(userLocation: userLocation)
    }
}
