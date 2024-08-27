//
// Created by Audrey SOBGOU ZEBAZE for the use in the Swift Island app
// Copyright © 2024 AppTrix AB. All rights reserved.
//

import Testing
import XCTest

// Before

class SwiftIslandTests: XCTestCase {

    func welcomeEveryone() {
        let engine = WelcomingEngine.shared.engine
        XCTAssertNotNil(engine.parts.first)
        XCTAssertGreaterThan(engine.batteryLevel, 0)
        try engine.start()
        XCTAssertTrue(engine.isRunning)
    }

    // ...
}


// After

struct SwiftIslandTests {

    @Test func welcomeEveryone() {
        let engine = WelcomingEngine.shared.engine
        try #require(engine.parts.first != nil)
        #expect(engine.welcomingGoodies > 0)
        try engine.start()
        #expect(engine.isRunning)
    }

    // ...
}
