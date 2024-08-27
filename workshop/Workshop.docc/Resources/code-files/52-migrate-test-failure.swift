//
// Created by Audrey SOBGOU ZEBAZE for the use in the Swift Island app
// Copyright © 2024 AppTrix AB. All rights reserved.
//

import Testing
import XCTest

// Before

class SwiftIslandTests: XCTestCase {
  func testSetupWorks() async {
    XCTExpectFailure(
      "Setup is missing power strips",
      options: .nonStrict()
    ) {
      try WelcomingEngine.shared.setup.start()
    }
    // ...
  }
  // ...
}

// After

struct SwiftIslandTests {

    @Test func grillWorks() async {
        withKnownIssue(
          "Setup is missing power strips",
          isIntermittent: true
        ) {
          try WelcomingEngine.shared.setup.start()
        }
        // ...
      }
      // ...
}
