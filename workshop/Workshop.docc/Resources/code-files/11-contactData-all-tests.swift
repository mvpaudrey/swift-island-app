//
// Created by Audrey SOBGOU ZEBAZE for the use in the Swift Island app
// Copyright © 2024 AppTrix AB. All rights reserved.
//

import Testing
@testable import Swift_Island

@Suite
struct ContactDataTests {

    // Test initialization and basic property assignment

    @Test func testInitWithValues() {
        let contact = ContactData(name: "John Doe", company: "Tech Corp", phone: "1234567890", email: "john@example.com", url: "https://example.com")

        // Use `#expect` to check every property
        #expect(contact.name == "John Doe")
        #expect(contact.company == "Tech Corp")
        #expect(contact.phone == "1234567890")
        #expect(contact.email == "john@example.com")
        #expect(contact.url == "https://example.com")
    }

    @Test(
        "Check various contact data",
        arguments: [
            ("John Doe", "Tech Corp", "1234567890", "john@example.com", "https://example.com"),
            ("", "", "", "", ""),
            ("Jane", "Startup Inc", "0987654321", "jane@example.com", "https://janesite.com")
        ]
    )
    func testInitialWithValues(name: String, company: String, phone: String, email: String, url: String) {
        let contact = ContactData(name: name, company: company, phone: phone, email: email, url: url)
        #expect(contact.name == name)
        #expect(contact.company == company)
        #expect(contact.phone == phone)
        #expect(contact.email == email)
        #expect(contact.url == url)
    }

    @Test func testVCardGeneration() async throws {
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

    @Test(
        "Base64 Encoding and Decoding",
        arguments: [
            ("John Doe", "Tech Corp", "1234567890", "john@example.com", "https://example.com"),
            ("Jane Doe", "Another Corp", "9876543210", "jane@example.com", "https://another.com"),
            ("Jane", "Startup Inc", "0987654321", "jane@example.com", "https://janesite.com")
        ]
    )
    func testBase64EncodingDecoding(name: String, company: String, phone: String, email: String, url: String) async throws {
        let contact = ContactData(name: name, company: company, phone: phone, email: email, url: url)
        if let base64Encoded = contact.base64Encoded {
            let decodedContact = ContactData(base64Encoded: base64Encoded)
            #expect(decodedContact == contact)
        } else {
            Issue.record("Base64 encoding failed")
        }
    }

    @Test(
        "Invalid Base64 string",
        arguments: [ "invalidString", "randomBadData", "" ]
    )
    // Test invalid base64 encoded string
    func testInitWithInvalidBase64Encoded(invalidBase64: String) async throws {
        let contact = ContactData(base64Encoded: invalidBase64)
        #expect(contact == nil)
    }

}
