//
//  SwiftIslandWorkshopTests.swift
//  SwiftIslandWorkshopTests
//
//  Created by Audrey SOBGOU ZEBAZE on 14/08/2024.
//

import Testing

struct SwiftIslandWorkshopTests {

    @Test func helloSwiftIsland() async throws {
        let greeting = "Hello, Swift Island!"
        #expect(greeting == "Hello")
    }

}
