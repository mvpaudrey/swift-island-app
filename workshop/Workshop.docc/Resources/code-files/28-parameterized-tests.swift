//
// Created by Audrey SOBGOU ZEBAZE for the use in the Swift Island app
// Copyright © 2024 AppTrix AB. All rights reserved.
//

import Testing
import Foundation

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
            // TODO: Check if the description matches what is expected
        }
    }
}
