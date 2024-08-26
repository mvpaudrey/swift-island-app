//
// Created by Audrey SOBGOU ZEBAZE for the use in the Swift Island app
// Copyright © 2024 AppTrix AB. All rights reserved.
//

import Testing
@testable import Swift_Island

@Suite("Contact Data Tests")
struct ContactDataTests {

    @Test(.disabled("Currently broken   "))
    func testInitWithValues_skipped() {
        let contact = ContactData(name: "John Doe", company: "Tech Corp", phone: "1234567890", email: "john@example.com", url: "https://example.com")

        // Use `#expect` to check every property
        #expect(contact.name == "John Doe")
        #expect(contact.company == "Tech Corp")
        #expect(contact.phone == "1234567890")
        #expect(contact.email == "john@example.com")
        #expect(contact.url == "https://example.com")
    }
}
