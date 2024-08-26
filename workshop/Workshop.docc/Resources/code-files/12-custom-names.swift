//
// Created by Audrey SOBGOU ZEBAZE for the use in the Swift Island app
// Copyright © 2024 AppTrix AB. All rights reserved.
//

import Testing
@testable import Swift_Island

@Suite("Contact Data Tests")
struct ContactDataTests {

    @Test("Custom name") func testVCardGeneration() async throws {
        let contact = ContactData(name: "John Doe", company: "Tech Corp", phone: "1234567890", email: "john@example.com", url: "https://example.com")

        let expectedVCard = """
            BEGIN:VCARD
            VERSION:3.0
            FN:John Doe
            ORG:Tech Corp
            TEL:1234567890
            EMAIL:john@example.com
            URL:https://example.com
            END:VCARD
            """

        #expect(contact.vCard == expectedVCard)
    }

}
