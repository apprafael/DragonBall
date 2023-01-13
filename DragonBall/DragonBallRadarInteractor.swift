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

class DragonBallRadarInteractor: NSObject, DragonBallRadarBussinessLogic {
    var viewModel: DragonRadarPresentationLogic?
    var dragonBalls: [DragonBall]
    private var locationManager: CLLocationManager
    private var dragonBallCountRange = 1...6

    override init() {
        self.locationManager = CLLocationManager()
        self.dragonBalls = [DragonBall]()
        super.init()
    }

    func createAndTrackingDragonBalls() {
        guard let userLocation = locationManager.location else { return }
        for _ in dragonBallCountRange {
            dragonBalls.append(DragonBall(userLocation: userLocation))
        }

        viewModel?.displayDragonBalls(dragonBalls: dragonBalls)
        startTracking()
    }

    private func trackUserDirection(magnecticHeading: CLLocationDirection) {
        viewModel?.directionChanged(angle: -magnecticHeading)
    }

    private func startTracking() {
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
}

extension DragonBallRadarInteractor: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        trackUserDirection(magnecticHeading: newHeading.magneticHeading)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = manager.location else { return }
        dragonBalls.forEach { $0.locationChanged(userLocation: userLocation) }
    }
}
