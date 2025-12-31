//
//  BestTimesStoreTests.swift
//  NQueensTests
//
//  Created by Enrique Bermúdez on 20/12/25.
//

import Foundation
import Testing
@testable import NQueens

struct BestTimesStoreTests {
    /// Creates a clean UserDefaults instance for testing
    private func makeTestDefaults(suiteName: String) -> UserDefaults {
        let defaults = UserDefaults(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        return defaults
    }

    @Test("Load returns empty array when no data")
    func loadEmpty() {
        let store = UserDefaultsBestTimesStore(defaults: makeTestDefaults(suiteName: "test.besttimes"))

        let result = store.load()

        #expect(result.isEmpty)
    }

    @Test("RecordTime saves time")
    func recordTimeSaves() {
        let store = UserDefaultsBestTimesStore(defaults: makeTestDefaults(suiteName: "test.besttimes2"))

        store.recordTime(n: 4, seconds: 100)

        // Verify persistence
        let loaded = store.load()
        #expect(loaded.count == 1)
        #expect(loaded[0].n == 4)
        #expect(loaded[0].seconds == 100)
    }

    @Test("Test maxRecords")
    func loadKeepsTop5() {
        let store = UserDefaultsBestTimesStore(defaults: makeTestDefaults(suiteName: "test.besttimes3"))

        // Add 12 times
        store.recordTime(n: 4, seconds: 600)
        store.recordTime(n: 4, seconds: 100)
        store.recordTime(n: 4, seconds: 200)
        store.recordTime(n: 4, seconds: 300)
        store.recordTime(n: 4, seconds: 400)
        store.recordTime(n: 4, seconds: 500)
        store.recordTime(n: 4, seconds: 500)
        store.recordTime(n: 4, seconds: 500)
        store.recordTime(n: 4, seconds: 500)
        store.recordTime(n: 4, seconds: 500)
        store.recordTime(n: 4, seconds: 3400)
        store.recordTime(n: 4, seconds: 1000)

        let result = store.load()
        #expect(result.count == UserDefaultsBestTimesStore.Constants.maxRecords)
        #expect(result[0].seconds == 100) // Best time first
        #expect(result[9].seconds == 600) // Worst should be 500
    }

    @Test("Load sorts by seconds ascending")
    func loadSorts() {
        let store = UserDefaultsBestTimesStore(defaults: makeTestDefaults(suiteName: "test.besttimes4"))

        store.recordTime(n: 4, seconds: 300)
        store.recordTime(n: 4, seconds: 100)
        store.recordTime(n: 4, seconds: 200)

        let result = store.load()
        #expect(result.count == 3)
        #expect(result[0].seconds == 100)
        #expect(result[1].seconds == 200)
        #expect(result[2].seconds == 300)
    }

    @Test("Multiple records with same seconds are kept")
    func multipleRecordsSameSeconds() {
        let store = UserDefaultsBestTimesStore(defaults: makeTestDefaults(suiteName: "test.besttimes5"))

        store.recordTime(n: 4, seconds: 100)
        store.recordTime(n: 8, seconds: 100)

        let result = store.load()
        #expect(result.count == 2)
    }
}
