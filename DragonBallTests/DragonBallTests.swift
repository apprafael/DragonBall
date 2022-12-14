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

    func testExample() throws {
        let location = CLLocation(latitude: 180.00000000000000, longitude: 180.00000000000000)
        dragonRadarViewModel?.setupDragonBalls(userLocation: location)
        XCTAssertNotEqual(dragonRadarViewModel?.dragonBalls.first?.location.coordinate.latitude, dragonRadarViewModel?.dragonBalls.last?.location.coordinate.latitude)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
