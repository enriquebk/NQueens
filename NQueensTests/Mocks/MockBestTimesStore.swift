//
//  MockBestTimesStore.swift
//  NQueensTests
//
//  Created by Enrique Bermúdez on 20/12/25.
//

import Foundation
@testable import NQueens

final class MockBestTimesStore: BestTimesStore {
    var storedTimes: [BestTime] = []
    var loadCallCount = 0
    var recordTimeCallCount = 0
    // periphery: ignore
    var lastRecordedN: Int?

    func load() -> [BestTime] {
        loadCallCount += 1
        return storedTimes
    }

    func recordTime(n: Int, seconds: Int) {
        recordTimeCallCount += 1
        lastRecordedN = n
        storedTimes.append(BestTime(n: n, seconds: seconds))
    }
}
