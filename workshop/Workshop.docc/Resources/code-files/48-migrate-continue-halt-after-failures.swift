//
// Created by Audrey SOBGOU ZEBAZE for the use in the Swift Island app
// Copyright © 2024 AppTrix AB. All rights reserved.
//

import Testing
import XCTest

// Before

class SwiftIslandTests: XCTestCase {

    func testWelcome() async {
        continueAfterFailure = false
        XCTAssertTrue(WelcomingEngine.shared.isApproved)
        // ...
    }
    // ...
}


// After

struct SwiftIslandTests {

    @Test func truck() throws {
        try #require(WelcomingEngine.shared.isApproved)
        // ...
    }
    //...

}
