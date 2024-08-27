//
// Created by Audrey SOBGOU ZEBAZE for the use in the Swift Island app
// Copyright © 2024 AppTrix AB. All rights reserved.
//

import Testing
import XCTest

// Before

class SwiftIslandTests: XCTestCase {

    func testConferenceEvents() async {
        let welcomedAttendees = expectation(description: "…")
        WelcomingEngine.shared.eventHandler = { event in
            if case .welcomedAttendees = event {
                welcomedAttendees.fulfill()
            }
        }
        await Attendees().scan(.qrCode)
        await fulfillment(of: [welcomedAttendees])
        // ...
    }
}


// After

struct SwiftIslandTests {

    @Test func conferenceEvents() async {
        await confirmation("…") { welcomedAttendees in
            WelcomingEngine.shared.eventHandler = { event in
            if case .welcomedAttendees = event {
                welcomedAttendees()
            }
          }
          await Attendees().scan(.qrCode)
        }
        ...
      }
    //...

}
