//
// Created by Audrey SOBGOU ZEBAZE for the use in the Swift Island app
// Copyright © 2024 AppTrix AB. All rights reserved.
//

import Testing
import Foundation

@testable import Swift_Island

enum BrewingError: Error {
    case oversteeped
    case needsMoreTime(optimalBrewTime: Int)
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

@Suite("BrewingTests")
struct BrewingTests {

    /// Required expectations
    @Test func brewAllGreenTeas() throws {
        try #require(throws: BrewingError.self) {
            try brewMultipleTeas(teaLeaves: ["Sencha", "EarlGrey", "Jasmine"], time: 2)
        }
    }

    private func brewMultipleTeas(teaLeaves: [String], time: Int) throws {
        let greenTeas = ["Sencha", "Jasmine"]

        for tea in teaLeaves {
            if greenTeas.contains(tea) {
                let teaLeaves = TeaLeaves(name: tea, optimalBrewTime: 3) // Assuming 3 min is optimal for green teas
                _ = try teaLeaves.brew(forMinutes: time)
            }
        }
    }
}
