//
// Created by Audrey SOBGOU ZEBAZE for the use in the Swift Island app
// Copyright © 2024 AppTrix AB. All rights reserved.
//

import Testing
import Foundation

@testable import Swift_Island

enum BrewingError: Error {
    case oversteeped
}

struct TeaLeaves {
    let name: String
    let optimalBrewTime: Int

    func brew(forMinutes: Int) throws -> CupOfTea {
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

    @Test func brewTeaSuccessfully() throws {
        let teaLeaves = TeaLeaves(name: "EarlGrey", optimalBrewTime: 4)
        let cupOfTea = try teaLeaves.brew(forMinutes: 3)
        #expect(cupOfTea.quality == .perfect)
    }

    /// Validating an error is thrown with do-catch (not recommended)
    @Test func brewTeaError() throws {
        let teaLeaves = TeaLeaves(name: "EarlGrey", optimalBrewTime: 3)

        do {
            _ = try teaLeaves.brew(forMinutes: 100)
        } catch is BrewingError {
            // This is the code path we are expecting
        } catch {
            Issue.record("Unexpected Error")
        }
    }
}
