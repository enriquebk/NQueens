//
//  UserDefaultsBestTimesStore.swift
//  NQueens
//
//  Created by Enrique Bermúdez on 20/12/25.
//

import Foundation

// periphery:ignore
final class UserDefaultsBestTimesStore: BestTimesStore {
    private let key = "best_times_v1"
    private let defaults: UserDefaults

    enum Constants {
        // Store maximun 10 best times
        static let maxRecords = 10
    }

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults

        // Check if the stored data needs to be cleared for UI testing purposes
        if ProcessInfo.processInfo.arguments.contains("UI-Testing-Reset-BestTimes") {
            defaults.removeObject(forKey: key)
        }
    }

    func load() -> [BestTime] {
        guard let data = defaults.data(forKey: key) else { return [] }
        return (try? JSONDecoder().decode([BestTime].self, from: data)) ?? []
    }

    func save(_ items: [BestTime]) {
        let data = try? JSONEncoder().encode(items)
        defaults.set(data, forKey: key)
        defaults.synchronize()
    }

    func recordTime(n: Int, seconds: Int) {
        var all = load()
        all.append(BestTime(n: n, seconds: seconds))
        all.sort { $0.seconds < $1.seconds }
        if all.count > Constants.maxRecords { all = Array(all.prefix(Constants.maxRecords)) }
        save(all)
    }
}
