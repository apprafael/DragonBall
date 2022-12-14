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
        setupDragonBalls(userLocation: locationManager?.location)
    }

    private func changeDragonsBallsPosition(direction: CLLocationDirection) {
        for index in dragonBalls.indices {
            dragonBalls[index].degree = direction
        }
    }

    private func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.delegate = self
        locationManager?.startUpdatingHeading()
        locationManager?.startUpdatingLocation()
    }

    func setupDragonBalls(userLocation: CLLocation?) {
        guard let userLocation = userLocation else { return }
        for _ in 0...6 {
            let dragonBallLat = userLocation.coordinate.latitude + Double.random(in: -0.099999999999999...0.099999999999999)
            let dragonBallLong = userLocation.coordinate.longitude + Double.random(in: -0.099999999999999...0.099999999999999)
            let dragonBallLocation = CLLocation(latitude: dragonBallLat, longitude: dragonBallLong)
            dragonBalls.append(DragonBall(location: dragonBallLocation, positionY: 300, degree: 0))
        }
    }

    private func updateDragonBallsDistance(userLocation: CLLocation) {
        for (index, dragonBall) in dragonBalls.enumerated() {
            var distance = Int(dragonBall.location.distance(from: userLocation)/10)
            distance = distance > 300 ? 300 : distance
            dragonBalls[index].positionY = distance
        }
    }
}

extension DragonRadarViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        changeDragonsBallsPosition(direction: newHeading.magneticHeading)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = manager.location else { return }
        updateDragonBallsDistance(userLocation: userLocation)
    }
}
