//
// Created by Audrey SOBGOU ZEBAZE for the use in the Swift Island app
// Copyright © 2024 AppTrix AB. All rights reserved.
//

import Testing
import Foundation
import SwiftIslandDataLogic
@testable import Swift_Island

extension Tag {
    @Tag static var nextEvent: Self
    @Tag static var futureEvent: Self
    @Tag static var allEvent: Self
}

/// This is a rewritten class of AppDataModelTests class but using _Swift Testing_
struct AppDataModelTests {

    private var dataLogicMock: DataLogicMock!

    init() {
        dataLogicMock = DataLogicMock()
    }

    // MARK: - Next Event

    @MainActor
    @Test(.tags(.nextEvent, .futureEvent))
    func testNextEvent_allFutureEvents_shouldReturnFirstEvent() async throws {
        // Given
        let events = [
            Event.forPreview(id: "1", startDate: Date(timeIntervalSinceNow: 60)),
            Event.forPreview(id: "2", startDate: Date(timeIntervalSinceNow: 61)),
            Event.forPreview(id: "3", startDate: Date(timeIntervalSinceNow: 62)),
            Event.forPreview(id: "4", startDate: Date(timeIntervalSinceNow: 63)),
            Event.forPreview(id: "5", startDate: Date(timeIntervalSinceNow: 64))
        ]
        dataLogicMock.fetchEventsReturnValue = events

        // When
        let sut = AppDataModel(dataLogic: dataLogicMock)
        let result = await sut.nextEvent()

        // Then
        #expect(result?.id == "1")
    }

    @MainActor
    @Test(.tags(.nextEvent, .futureEvent))
    func testNextEvent_someFutureEvents_shouldReturnThirdEvent() async throws {
        // Given
        let events = [
            Event.forPreview(id: "1", startDate: Date(timeIntervalSinceNow: -60)),
            Event.forPreview(id: "2", startDate: Date(timeIntervalSinceNow: -59)),
            Event.forPreview(id: "3", startDate: Date(timeIntervalSinceNow: 60)),
            Event.forPreview(id: "4", startDate: Date(timeIntervalSinceNow: 61)),
            Event.forPreview(id: "5", startDate: Date(timeIntervalSinceNow: 62))
        ]
        dataLogicMock.fetchEventsReturnValue = events

        // When
        let sut = AppDataModel(dataLogic: dataLogicMock)
        let result = await sut.nextEvent()

        // Then
        #expect(result?.id == "3")
    }
}
