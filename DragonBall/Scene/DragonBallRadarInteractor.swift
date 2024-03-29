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
    var dragonBalls: [DragonBall] = []
    private var locationManager: CLLocationManager = CLLocationManager()
    private var dragonBallCountRange = 1...6

    func createAndTrackingDragonBalls() {
        locationManager.delegate = self
        
        askLocationPermissionIfNeeded()
    }

    private func trackUserDirection(magnecticHeading: CLLocationDirection) {
        viewModel?.directionChanged(angle: -magnecticHeading)
    }
    
    private func askLocationPermissionIfNeeded() {
        let status = locationManager.authorizationStatus
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            startTrackingAndCreateDragonBalls()
        } else {
            locationManager.requestAlwaysAuthorization()
        }
    }

    private func startTrackingAndCreateDragonBalls() {
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        
        guard let userLocation = locationManager.location else { return }
        for _ in dragonBallCountRange {
            dragonBalls.append(DragonBall(userLocation: userLocation))
        }

        viewModel?.displayDragonBalls(dragonBalls: dragonBalls)
    }
}

extension DragonBallRadarInteractor: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:  // Location services are available.
            startTrackingAndCreateDragonBalls()
            break

        case .restricted, .denied:  // Location services currently unavailable.
            break

        case .notDetermined:        // Authorization not determined yet.
           manager.requestWhenInUseAuthorization()
            break

        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        trackUserDirection(magnecticHeading: newHeading.magneticHeading)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = manager.location else { return }
        dragonBalls.forEach { $0.locationChanged(userLocation: userLocation) }
        viewModel?.displayDragonBalls(dragonBalls: dragonBalls)
    }
}
