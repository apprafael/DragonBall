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
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.delegate = self
        locationManager?.startUpdatingHeading()
        dragonBalls.append(DragonBall(positionY: 300, degree: 0))
        dragonBalls.append(DragonBall(positionY: 70, degree: 0))
        dragonBalls.append(DragonBall( positionY: -60, degree: 0))
    }

    func changeDragonsBallsPosition(direction: CLLocationDirection) {
        for index in dragonBalls.indices {
            dragonBalls[index].degree = direction
        }
    }
}

extension DragonRadarViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        changeDragonsBallsPosition(direction: newHeading.magneticHeading)
    }
}
