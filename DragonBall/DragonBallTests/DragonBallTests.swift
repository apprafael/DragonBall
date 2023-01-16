//
//  DragonBallTests.swift
//  DragonBallTests
//
//  Created by Rafael Almeida on 12/6/22.
//

import XCTest
import CoreLocation
@testable import DragonBall

final class DragonBallTests: XCTestCase {
    var dragonRadarViewModel: DragonRadarViewModel?

    override func setUpWithError() throws {
        dragonRadarViewModel = DragonRadarViewModel()
    }

    override func tearDownWithError() throws {
        dragonRadarViewModel = nil
    }

    func testDistance() {
        let location = CLLocation(latitude: -23.647656646988395, longitude: -46.557121753742834)
        let dragonBall = DragonBall(userLocation: location)
        dragonRadarViewModel?.dragonBalls.append(dragonBall)
        let firstDistance = dragonRadarViewModel?.dragonBalls.first?.distance
        let remoteLocation = CLLocation(latitude: -3.9531129377989, longitude: -43.91739217781292)
        dragonRadarViewModel?.dragonBalls.first?.locationChanged(userLocation: remoteLocation)
        let remoteDistance = dragonRadarViewModel?.dragonBalls.first?.distance
        XCTAssertTrue(remoteDistance ?? 0 > firstDistance ?? 0)
        
    }

    func testDirection() {
        let location = CLLocation(latitude: -23.647656646988395, longitude: -46.557121753742834)
        let dragonBall = DragonBall(userLocation: location)
        dragonRadarViewModel?.dragonBalls.append(dragonBall)
        let remoteLocation = CLLocation(latitude: -36.22960109959959, longitude: -47.33416786597348)
        dragonRadarViewModel?.dragonBalls.first?.locationChanged(userLocation: remoteLocation)
        let remoteDirection = dragonRadarViewModel?.dragonBalls.first?.direction
        XCTAssertEqual(remoteDirection ?? 0 > -177.23208319717727, true)
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
