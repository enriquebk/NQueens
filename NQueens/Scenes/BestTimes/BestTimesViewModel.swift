//
//  BestTimesViewModel.swift
//  NQueens
//
//  Created by Enrique Bermúdez on 19/12/25.
//

import Foundation

// MARK: - ViewModel

final class BestTimesViewModel: ViewModel {
    @Published var state: BestTimesState
    private let store: BestTimesStore

    init(store: BestTimesStore) {
        self.state = BestTimesState()
        self.store = store
    }

    // MARK: - State

    struct BestTimesState {
        var items: [BestTime] = []
    }

    // MARK: - Events

    enum BestTimesEvent {
        case onAppear
        case updateItems([BestTime])
    }

    // MARK: - Effects

    enum BestTimesEffect {
        case loadItems
    }

    // MARK: - Event Handler

    static func reduce(_ event: BestTimesEvent, currentState: BestTimesState) -> (BestTimesState, [BestTimesEffect]) {
        var newState = currentState
        var effects: [BestTimesEffect] = []

        switch event {
        case .onAppear:
            effects.append(.loadItems)
        case let .updateItems(items):
            newState.items = items
        }

        return (newState, effects)
    }

    // MARK: - Effect Processor

    func process(_ effect: BestTimesEffect) {
        switch effect {
        case .loadItems:
            let newItems = store.load().sorted { $0.seconds < $1.seconds }
            handle(.updateItems(newItems))
        }
    }
}
