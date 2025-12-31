//
//  BestTime.swift
//  NQueens
//
//  Created by Enrique Bermúdez on 19/12/25.
//

import Foundation

struct BestTime: Codable {
    let n: Int
    let seconds: Int
    let date: Date

    init(n: Int, seconds: Int, date: Date = .now) {
        self.n = n
        self.seconds = seconds
        self.date = date
    }
}

/// Protocol for local storage and retrieval of best times
protocol BestTimesStore {
    func load() -> [BestTime]
    func recordTime(n: Int, seconds: Int)
}
