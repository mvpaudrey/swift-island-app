//
// Created by Audrey SOBGOU ZEBAZE for the use in the Swift Island app
// Copyright © 2024 AppTrix AB. All rights reserved.
//

import Testing
import Foundation

@testable import Swift_Island

enum Flavor {
    case vanilla, chocolate, strawberry, mintChip, rockyRoad, pistachio, pineapple

    var containsNuts: Bool {
        switch self {
        case .rockyRoad, .pistachio:
            return true
        default:
            return false
        }
    }
}

enum Container {
    case cone
    case cup
}

enum Topping {
    case sprinkles
    case whippedCream
}


struct SoftServe: CustomTestStringConvertible, Equatable {
    let flavor: Flavor
    let container: Container
    let toppings: [Topping]

    var testDescription: String {
        "\(flavor) in a \(container)"
    }
}

@Suite("Conforming to CustomTestStringConvertible")
struct SoftServeTests {

    // Parameterizing a test
    @Test
    func doesContainNuts() throws{
        for flavor in [Flavor.vanilla, .chocolate, .strawberry, .mintChip] {
            try #require(!flavor.containsNuts)
        }
    }

    @Test(arguments: [
        SoftServe(flavor: .vanilla, container: .cone, toppings: [.sprinkles]),
        SoftServe(flavor: .chocolate, container: .cone, toppings: [.sprinkles]),
        SoftServe(flavor: .pineapple, container: .cup, toppings: [.whippedCream])
    ])
    func softServeFlavors(_ softServe: SoftServe) {
        switch softServe {
            // Check if the description matches what is expected

        case SoftServe(flavor: .vanilla, container: .cone, toppings: [.sprinkles]):
            #expect(softServe.testDescription == "vanilla in a cone")

        case SoftServe(flavor: .chocolate, container: .cone, toppings: [.sprinkles]):
            #expect(softServe.testDescription == "chocolate in a cone")

        case SoftServe(flavor: .pineapple, container: .cup, toppings: [.whippedCream]):
            #expect(softServe.testDescription == "pineapple in a cup")

        default:
            // Fail the test if none of the cases match (optional)
            Issue.record("Unexpected soft serve combination")
        }
    }
}

enum BrewingError: Error, Equatable {
    case oversteeped
    case needsMoreTime(optimalBrewTime: Int)
    case invalidBrewForGreenTea
}

struct TeaLeaves {
    let name: String
    let optimalBrewTime: Int

    func brew(forMinutes: Int) throws -> CupOfTea {
        if forMinutes < optimalBrewTime {
            throw BrewingError.needsMoreTime(optimalBrewTime: optimalBrewTime)
        }

        let quality: CupOfTea.Quality

        switch forMinutes {
        case 10...20:
            quality = .bad
        case let minutes where minutes < 5:
            quality = .perfect
        case let minutes where minutes > 20:
            throw BrewingError.oversteeped
        default:
            quality = .normal
        }

        return CupOfTea(quality: quality)
    }
}

struct CupOfTea {

    enum Quality {
        case perfect
        case normal
        case bad
    }
    let quality: Quality
}

struct BreweryTests {

    @Test func brewTeaSuccessfully() throws {
        let teaLeaves = TeaLeaves(name: "EarlGrey", optimalBrewTime: 4)
        let cupOfTea = try teaLeaves.brew(forMinutes: 3)
        #expect(cupOfTea.quality == .perfect)
    }

    /// Validating an error is thrown with do-catch (not recommended) ✅
    /*@Test func brewTeaError() throws {
        let teaLeaves = TeaLeaves(name: "EarlGrey", optimalBrewTime: 3)

        do {
            _ = try teaLeaves.brew(forMinutes: 100)
        } catch is BrewingError {
            // This is the code path we are expecting
        } catch {
            Issue.record("Unexpected Error")
        }
    }*/

    /// Validating a type of error ✅
    @Test func brewTeaError() throws {
        let teaLeaves = TeaLeaves(name: "EarlGrey", optimalBrewTime: 4)
        #expect(throws: BrewingError.self) {
            try teaLeaves.brew(forMinutes: 200) // We don't want this to fail the test!
        }
    }

    /// Validating a specific error ✅
    @Test func brewTeaSpecificError() throws {
        let teaLeaves = TeaLeaves(name: "EarlGrey", optimalBrewTime: 4)
        #expect(throws: BrewingError.oversteeped) {
            try teaLeaves.brew(forMinutes: 200) // We don't want this to fail the test!
        }
    }

    /// Complicated validation
    @Test func brewTea() {
        let teaLeaves = TeaLeaves(name: "EarlGrey", optimalBrewTime: 4)
        #expect {
            try teaLeaves.brew(forMinutes: 3)
        } throws: { error in
            guard let error = error as? BrewingError,
                  case let .needsMoreTime(optimalBrewTime) = error else {
                return false
            }
            return optimalBrewTime == 4
        }
    }

    /// Throwing expectation ❌
    /*@Test func brewAllGreenTeasThrowingExpectation() {
      #expect(throws: BrewingError.self) {
        brewMultipleTeas(teaLeaves: ["Sencha", "EarlGrey", "Jasmine"], time: 2)
      }
    }

    private func brewMultipleTeas(teaLeaves: [String], time: Int) {
        let greenTeas = ["Sencha", "Jasmine"]

        for tea in teaLeaves {
            if greenTeas.contains(tea) {
                // Assuming optimal brew time for green tea is 3 minutes
                let teaLeaves = TeaLeaves(name: tea, optimalBrewTime: 3)
                // This throws BrewingError if time is less than 3
                _ = try teaLeaves.brew(forMinutes: time)
            }
        }
    }*/

    /// Required expectations ✅
    @Test func brewAllGreenTeasRequiredExpectations() throws {
        try #require(throws: BrewingError.self) {
            try brewMultipleTeasRequire(teaLeaves: ["Sencha", "EarlGrey", "Jasmine"], time: 2)
        }
    }

    private func brewMultipleTeasRequire(teaLeaves: [String], time: Int) throws {
        let greenTeas = ["Sencha", "Jasmine"]

        for tea in teaLeaves {
            if greenTeas.contains(tea) {
                let teaLeaves = TeaLeaves(name: tea, optimalBrewTime: 3) // Assuming 3 min is optimal for green teas
                _ = try teaLeaves.brew(forMinutes: time)
            }
        }
    }
}

struct AppFeatures {
    static var isCommentingEnabled = true
    // ...
}

@Suite("Contact Data Tests", .serialized)
struct ContactDataTests {

    @Test(.enabled(if: AppFeatures.isCommentingEnabled))
    func testInitWithValues_withConditions() {
        let contact = ContactData(name: "John Doe", company: "Tech Corp", phone: "1234567890", email: "john@example.com", url: "https://example.com")

        // Use `#expect` to check every property
        #expect(contact.name == "John Doe")
        #expect(contact.company == "Tech Corp")
        #expect(contact.phone == "1234567890")
        #expect(contact.email == "john@example.com")
        #expect(contact.url == "https://example.com")
    }


    @Test(.disabled("Due to a known crash"),
          .bug("https://example.org/bugs/1234", "Program crashes at <symbol>"))
    func testInitWithValues_thatRefersABug() {
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
