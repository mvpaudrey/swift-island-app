//
// Created by Audrey SOBGOU ZEBAZE for the use in the Swift Island app
// Copyright © 2024 AppTrix AB. All rights reserved.
//

import Testing
@testable import Swift_Island

@Suite("Contact Data Tests", .serialized)
struct ContactDataTests {

    @Suite("Sub Category of Contact Data tests")
    struct ContactDataTSubCategoryTests {
        // ...
    }

    @Test(arguments: [])
    func test1(contact: ContactData) { /* ... */ }
    @Test func baking() { /* ... */ }
    @Test func decorating() { /* ... */ }
    @Test func eating() { /* ... */ }
}
