//
// Created by Audrey SOBGOU ZEBAZE for the use in the Swift Island app
// Copyright © 2024 AppTrix AB. All rights reserved.
//

import Testing
import XCTest

// Before

class SwiftIslandTests: XCTestCase {

    func testEngineWorks() throws {
        let engine = WelcomingEngine.shared.engine
        guard case .positivity = engine else {
            XCTFail("Engine is not positivity")
            return
        }
        // ..
      }

    // ...
}


// After

struct SwiftIslandTests {

    @Test func engineWorks() throws {
        let engine = WelcomingEngine.shared.engine
        guard case .positivity = engine else {
            Issue.record("Engine is not positivity")
            return
        }
        // ...
    }
    //...

}
