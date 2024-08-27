//
// Created by Audrey SOBGOU ZEBAZE for the use in the Swift Island app
// Copyright © 2024 AppTrix AB. All rights reserved.
//

import Testing
import XCTest

// Before

class SwiftIslandTests: XCTestCase {
    func testAttendeesAreWelcomed() throws {
        try XCTSkipIf(WelcomingEngine.shouldProceedToSecondStep)
        try XCTSkipUnless(WelcomingEngine.welcome(.attendees))
        //...
    }
    //...
}


// After

@Suite(.disabled(if: WelcomingEngine.shouldProceedToSecondStep))
struct SwiftIslandTests {
    @Test(.enabled(if: shouldProceedToSecondStep.welcome(.attendees)))
    func areAttendeesWelcomed() {
        // ...
    }
    // ...
}
