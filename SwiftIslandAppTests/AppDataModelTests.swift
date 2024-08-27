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
    @Tag static var allEvents: Self
    @Tag static var noEvent: Self
    @Tag static var location: Self
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

    @MainActor
    @Test(.tags(.nextEvent, .allEvents))
    func testNextEvent_allEventsHavePassed_shouldReturnNil() async throws {
        // Given
        let events = [
            Event.forPreview(id: "1", startDate: Date(timeIntervalSinceNow: -60)),
            Event.forPreview(id: "2", startDate: Date(timeIntervalSinceNow: -59)),
            Event.forPreview(id: "3", startDate: Date(timeIntervalSinceNow: -58)),
            Event.forPreview(id: "4", startDate: Date(timeIntervalSinceNow: -57)),
            Event.forPreview(id: "5", startDate: Date(timeIntervalSinceNow: -56))
        ]
        dataLogicMock.fetchEventsReturnValue = events

        // When
        let sut = AppDataModel(dataLogic: dataLogicMock)
        let result = await sut.nextEvent()

        // Then
        #expect(result == nil)
    }

    @MainActor
    @Test(.tags(.nextEvent, .noEvent))
    func testNextEvent_noEvents_shouldReturnNil() async throws {
        // Given
        dataLogicMock.fetchEventsReturnValue = []

        // When
        let sut = AppDataModel(dataLogic: dataLogicMock)
        let result = await sut.nextEvent()

        // Then
        #expect(result == nil)
    }

    // MARK: - Locations

    @MainActor
    @Test(.tags(.location))
    func testFetchLocations_existingLocations_shouldReturnLocations() async throws {
        // Given
        dataLogicMock.fetchLocationsReturnValue = [
            Location.forPreview(id: "1"),
            Location.forPreview(id: "2")
        ]

        // When
        let sut = AppDataModel(dataLogic: dataLogicMock)
        await sut.fetchLocations()

        // Then
        let locations = sut.locations
        #expect(locations.count == 2)
    }

    @MainActor
    @Test(.tags(.location))
    func testFetchLocations_noLocations_shouldReturnNoLocations() async throws {
        // Given
        dataLogicMock.fetchLocationsReturnValue = []

        // When
        let sut = AppDataModel(dataLogic: dataLogicMock)
        await sut.fetchLocations()

        // Then
        let locations = sut.locations
        #expect(locations.count == 0)
    }
}
