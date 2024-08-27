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
        let part = try XCTUnwrap(engine.parts.first)
        // ...
      }

    // ...
}


// After

struct SwiftIslandTests {

    @Test func engineWorks() throws {
        let engine = WelcomingEngine.shared.engine
        let part = try #require(engine.parts.first)
        // ...
    }
    //...

}
