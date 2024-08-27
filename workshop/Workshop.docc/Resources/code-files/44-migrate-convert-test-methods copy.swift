//
// Created by Audrey SOBGOU ZEBAZE for the use in the Swift Island app
// Copyright © 2024 AppTrix AB. All rights reserved.
//

import Testing
import XCTest

// Before

class SwiftIslandTests: XCTestCase {
    var welcomingGoodies: NSNumber!

    override func setUp() async throws {
        welcomingGoodies = 5

        func welcomeEveryone() { /* ... */ }
    }

    // ...
}

// After

struct SwiftIslandTests {
    var welcomingGoodies: NSNumber

    init() async throws {
        welcomingGoodies = 5
    }

    @Test func welcomeEveryone() { /* ... */ }
    // ...
}
