//
//  DragonBallRadarInteractor.swift
//  DragonBall
//
//  Created by Rafael Almeida on 12/23/22.
//

import Foundation
import CoreLocation

protocol DragonBallRadarBussinessLogic {
    func createAndTrackingDragonBalls()
}

class DragonBallRadarInteractor: NSObject {
    var viewModel: DragonRadarPresentationLogic?
    private var locationManager: CLLocationManager
    var dragonBalls: [DragonBall]

    override init() {
        self.locationManager = CLLocationManager()
        self.dragonBalls = [DragonBall]()
        super.init()
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

    private func trackingDragonBallDistance(userLocation: CLLocation) {
        for (index, dragonBall) in dragonBalls.enumerated() {
            let distance = Int(dragonBall.location.distance(from: userLocation)/10)
            dragonBalls[index].distance = distance
            let dragonBallDirection = getBearingBetweenTwoPoints1(point1: userLocation, point2: dragonBall.location)
            dragonBalls[index].direction = dragonBallDirection
        }
    }
    
    private func trackingDragonBallDirection(magnecticHeading: CLLocationDirection) {
        viewModel?.directionChanged(angle: magnecticHeading)
    }

    private func startTrackingDragonBalls() {
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
}

extension DragonBallRadarInteractor: DragonBallRadarBussinessLogic {
    func createAndTrackingDragonBalls() {
        guard let userLocation = locationManager.location else { return }
        for _ in 1...6 {
            let dragonBallLat = userLocation.coordinate.latitude + Double.random(in: -0.029999999999999...0.029999999999999)
            let dragonBallLong = userLocation.coordinate.longitude + Double.random(in: -0.029999999999999...0.029999999999999)
            let dragonBallLocation = CLLocation(latitude: dragonBallLat, longitude: dragonBallLong)
            let distance = Int(dragonBallLocation.distance(from: userLocation)/10)
            dragonBalls.append(DragonBall(location: dragonBallLocation, distance: distance, direction: 0))
        }

        viewModel?.displayDragonBalls(dragonBalls: dragonBalls)
        startTrackingDragonBalls()
    }
}

extension DragonBallRadarInteractor: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        trackingDragonBallDirection(magnecticHeading: newHeading.magneticHeading)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = manager.location else { return }
        trackingDragonBallDistance(userLocation: userLocation)
    }
}
