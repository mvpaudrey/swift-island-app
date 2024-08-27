//
// Created by Audrey SOBGOU ZEBAZE for the use in the Swift Island app
// Copyright © 2024 AppTrix AB. All rights reserved.
//

import Testing
import XCTest

// Before

class SwiftIslandTests: XCTestCase {

    func testSetupWorks() async {
        XCTExpectFailure("We are out of power strips@       ") {
            try WelcomingEngine.shared.setup.start()
        }
        // ...
    }
    // ...
}

// After

struct SwiftIslandTests {

    @Test func setupWorks() async {
        withKnownIssue("We are out of power strips") {
            try WelcomingEngine.shared.setup.start()
        }
        //...
    }

    //...
}
