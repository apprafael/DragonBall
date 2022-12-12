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
    var dragonBalls = [DragonBall]()
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.delegate = self
        locationManager?.startUpdatingHeading()
        dragonBalls.append(DragonBall(positionX: 70, positionY: 300))
        dragonBalls.append(DragonBall(positionX: -100, positionY: 70))
        dragonBalls.append(DragonBall(positionX: 100, positionY: -60))
    }
}

extension DragonRadarViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print(newHeading.magneticHeading)
    }
}
