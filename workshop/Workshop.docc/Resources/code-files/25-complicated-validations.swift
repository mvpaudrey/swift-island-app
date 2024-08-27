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
}
