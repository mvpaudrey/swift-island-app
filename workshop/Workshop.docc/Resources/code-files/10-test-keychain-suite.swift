//
// Created by Audrey SOBGOU ZEBAZE for the use in the Swift Island app
// Copyright © 2024 AppTrix AB. All rights reserved.
//

import Foundation
import Testing
@testable import Swift_Island

@Suite
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

        let testKey = KeychainAttrAccount.tickets
        let testObject = TestObject(id: 1, name: "SampleObject")

        try #require(mockManager.get(key: testKey) == nil)

        try mockManager.store(key: testKey, data: testObject)

        let retrievedObject: TestObject? = try mockManager.get(key: testKey)
        #expect(retrievedObject == testObject)
    }

    /// Test deleting a value from the mock keychain
    @Test
    func testDeleteKeychainValue() async throws {
        let testKey = KeychainAttrAccount.tickets
        let testValue = "TestValueForDeletion"

        try mockManager.store(key: testKey, data: testValue)

        let retrievedValue: String? = try mockManager.get(key: testKey)
        #expect(retrievedValue == testValue)

        try mockManager.delete(key: testKey)

        let afterDeletionValue: String? = try mockManager.get(key: testKey)
        #expect(afterDeletionValue == nil)
    }

    /// Test error handling when retrieving a non-existing key
    @Test
    func testRetrieveNonExistingKeychainValue() async throws {
        let testKey = KeychainAttrAccount.tickets

        try? mockManager.delete(key: testKey)

        let retrievedValue: String? = try mockManager.get(key: testKey)
        #expect(retrievedValue == nil)
    }

    /// Test error handling for delete operation
    @Test
    func testDeleteNonExistingKey() async throws {
        let testKey = KeychainAttrAccount.tickets

        try? mockManager.delete(key: testKey)

        try mockManager.delete(key: testKey)
        let retrievedValue: String? = try mockManager.get(key: testKey)
        #expect(retrievedValue == nil)
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
        if let stringData = data as? String {
            storage[key.rawValue] = stringData.data(using: .utf8)
        } else {
            let encodedData = try JSONEncoder().encode(data)
            storage[key.rawValue] = encodedData
        }
    }
}
