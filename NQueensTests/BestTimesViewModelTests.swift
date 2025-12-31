//
//  BestTimesViewModelTests.swift
//  NQueensTests
//
//  Created by Enrique Bermúdez on 20/12/25.
//

import Testing
@testable import NQueens

struct BestTimesViewModelTests {
    @MainActor @Test("Initial state is empty")
    func initialState() {
        let mockStore = MockBestTimesStore()
        let viewModel = BestTimesViewModel(store: mockStore)

        #expect(viewModel.state.items.isEmpty)
    }

    @MainActor @Test("Load populates items from store")
    func loadPopulatesItems() {
        let mockStore = MockBestTimesStore()
        let times = [
            BestTime(n: 4, seconds: 100),
            BestTime(n: 8, seconds: 200),
        ]
        mockStore.storedTimes = times

        let viewModel = BestTimesViewModel(store: mockStore)
        viewModel.handle(.onAppear)

        #expect(viewModel.state.items.count == 2)
        #expect(mockStore.loadCallCount == 1)
    }

    @MainActor @Test("Load sorts items by seconds ascending")
    func loadSortsBySeconds() {
        let mockStore = MockBestTimesStore()
        let times = [
            BestTime(n: 8, seconds: 200),
            BestTime(n: 4, seconds: 50),
            BestTime(n: 6, seconds: 150),
        ]
        mockStore.storedTimes = times

        let viewModel = BestTimesViewModel(store: mockStore)
        viewModel.handle(.onAppear)

        #expect(viewModel.state.items.count == 3)
        #expect(viewModel.state.items[0].seconds == 50)
        #expect(viewModel.state.items[1].seconds == 150)
        #expect(viewModel.state.items[2].seconds == 200)
    }
}
