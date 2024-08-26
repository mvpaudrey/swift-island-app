//
// Created by Audrey SOBGOU ZEBAZE for the use in the Swift Island app
// Copyright © 2024 AppTrix AB. All rights reserved.
//

import Foundation
import Testing
@testable import Swift_Island

struct KeychainManagerTests {

    private var mockManager: MockKeychainManager!

    init() {
        mockManager = MockKeychainManager()
    }

    struct TestObject: Codable, Equatable {
        let id: Int
        let name: String
    }

    @Test func testStoreAndRetrieveDecodableObject() throws {

        //TODO: Test storing and retrieving of decodable object `TestObject`

        // Given
        let testKey = KeychainAttrAccount.tickets
        let testObject = TestObject(id: 1, name: "SampleObject")

        // TODO: Ensure key doesn't exist before storing by using #require macro
        try #require(mockManager.get(key: testKey) == nil)

        try mockManager.store(key: testKey, data: testObject)

        let retrievedObject: TestObject? = try mockManager.get(key: testKey)
        #expect(retrievedObject == testObject)
    }

}


class MockKeychainManager: KeychainManaging {
    private var storage: [String: Data] = [:]

    func get(key: KeychainAttrAccount) throws -> String? {
        guard let data = storage[key.rawValue], let value = String(data: data, encoding: .utf8) else { return nil }
        return value
    }

    func get<T: Decodable>(key: KeychainAttrAccount) throws -> T? {
        guard let data = storage[key.rawValue] else { return nil }
        return try JSONDecoder().decode(T.self, from: data)
    }

    func delete(key: KeychainAttrAccount) throws {
        storage[key.rawValue] = nil
    }

    func store<T: Encodable>(key: KeychainAttrAccount, data: T) throws {
        let encodedData = try JSONEncoder().encode(data)
        storage[key.rawValue] = encodedData
    }
}
