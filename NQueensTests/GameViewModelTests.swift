//
//  GameViewModelTests.swift
//  NQueensTests
//
//  Created by Enrique Bermúdez on 20/12/25.
//

import Combine
import Testing
@testable import NQueens

struct GameViewModelTests {
    @MainActor @Test("Initial state is correct")
    func initialState() {
        let mockStore = MockBestTimesStore()
        let mockSound = MockSoundFxManager()
        var winCalled = false
        let viewModel = GameViewModel(n: 4, bestTimesStore: mockStore, soundFxManager: mockSound) { _, _ in
            winCalled = true
        }

        #expect(viewModel.state.n == 4)
        #expect(viewModel.state.queens.isEmpty)
        #expect(viewModel.state.conflicts.isEmpty)
        #expect(viewModel.state.secondsElapsed == 0)
        #expect(winCalled == false)
    }

    @MainActor @Test("Toggle queen adds queen")
    func toggleQueenAdds() {
        let mockStore = MockBestTimesStore()
        let mockSound = MockSoundFxManager()
        let viewModel = GameViewModel(n: 4, bestTimesStore: mockStore, soundFxManager: mockSound) { _, _ in }

        viewModel.handle(.toggleQueen(row: 0, col: 0))

        #expect(viewModel.state.queens.contains(QueenPosition(row: 0, col: 0)))
        #expect(mockSound.playQueenTapCallCount == 1)
    }

    @MainActor @Test("Toggle queen removes queen")
    func toggleQueenRemoves() {
        let mockStore = MockBestTimesStore()
        let mockSound = MockSoundFxManager()
        let viewModel = GameViewModel(n: 4, bestTimesStore: mockStore, soundFxManager: mockSound) { _, _ in }

        viewModel.handle(.toggleQueen(row: 0, col: 0))
        #expect(viewModel.state.queens.contains(QueenPosition(row: 0, col: 0)))

        viewModel.handle(.toggleQueen(row: 0, col: 0))

        #expect(!viewModel.state.queens.contains(QueenPosition(row: 0, col: 0)))
        #expect(mockSound.playQueenTapCallCount == 2)
    }

    @MainActor @Test("Conflicts are detected")
    func conflictsDetected() {
        let mockStore = MockBestTimesStore()
        let mockSound = MockSoundFxManager()
        let viewModel = GameViewModel(n: 4, bestTimesStore: mockStore, soundFxManager: mockSound) { _, _ in }

        // Place two queens in the same row
        viewModel.handle(.toggleQueen(row: 0, col: 0))
        viewModel.handle(.toggleQueen(row: 0, col: 1))

        #expect(!viewModel.state.conflicts.isEmpty)
        #expect(viewModel.state.conflicts.contains(QueenPosition(row: 0, col: 0)))
        #expect(viewModel.state.conflicts.contains(QueenPosition(row: 0, col: 1)))
    }

    @MainActor @Test("Reset clears queens and seconds")
    func resetClears() async throws {
        let mockStore = MockBestTimesStore()
        let mockSound = MockSoundFxManager()
        let viewModel = GameViewModel(n: 4, bestTimesStore: mockStore, soundFxManager: mockSound) { _, _ in }

        viewModel.handle(.onAppear)
        viewModel.handle(.toggleQueen(row: 0, col: 0))
        viewModel.handle(.toggleQueen(row: 1, col: 1))

        // Wait a bit for timer to increment
        try await Task.sleep(nanoseconds: 1_100_000_000) // 1.1 seconds

        let secondsBeforeReset = viewModel.state.secondsElapsed
        #expect(secondsBeforeReset > 0)
        #expect(!viewModel.state.queens.isEmpty)

        viewModel.handle(.reset)

        #expect(viewModel.state.queens.isEmpty)
        #expect(viewModel.state.secondsElapsed == 0)
    }

    @MainActor @Test("Complete solution triggers win callback")
    func completeSolutionTriggersWin() async throws {
        let mockStore = MockBestTimesStore()
        let mockSound = MockSoundFxManager()
        var winCalled = false
        var winSeconds: Int?
        var winN: Int?
        let viewModel = GameViewModel(n: 4, bestTimesStore: mockStore, soundFxManager: mockSound) { seconds, n in
            winCalled = true
            winSeconds = seconds
            winN = n
        }

        // Valid 4x4 solution
        viewModel.handle(.toggleQueen(row: 0, col: 1))
        viewModel.handle(.toggleQueen(row: 1, col: 3))
        viewModel.handle(.toggleQueen(row: 2, col: 0))
        viewModel.handle(.toggleQueen(row: 3, col: 2))

        // Wait a moment for validation
        try await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds

        #expect(winCalled == true)
        #expect(winSeconds == viewModel.state.secondsElapsed)
        #expect(winN == 4)
        #expect(viewModel.state.conflicts.isEmpty)
    }

    @MainActor @Test("Win triggers best times store")
    func winTriggersBestTimesStore() async throws {
        let mockStore = MockBestTimesStore()
        let mockSound = MockSoundFxManager()
        let viewModel = GameViewModel(n: 4, bestTimesStore: mockStore, soundFxManager: mockSound) { _, _ in }

        // Wait a bit for timer
        try await Task.sleep(nanoseconds: 1_100_000_000) // 1.1 seconds

        // Valid 4x4 solution
        viewModel.handle(.toggleQueen(row: 0, col: 1))
        viewModel.handle(.toggleQueen(row: 1, col: 3))
        viewModel.handle(.toggleQueen(row: 2, col: 0))
        viewModel.handle(.toggleQueen(row: 3, col: 2))

        // Wait for validation
        try await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds

        #expect(mockStore.recordTimeCallCount == 1)
        #expect(mockStore.lastRecordedN == 4)
    }

    @MainActor @Test("Timer increments seconds")
    func timerIncrements() async throws {
        let mockStore = MockBestTimesStore()
        let mockSound = MockSoundFxManager()
        let viewModel = GameViewModel(n: 4, bestTimesStore: mockStore, soundFxManager: mockSound) { _, _ in }

        viewModel.handle(.onAppear) // Start timer
        let initialSeconds = viewModel.state.secondsElapsed

        // Wait for timer to tick
        try await Task.sleep(nanoseconds: 1_100_000_000) // 1.1 seconds

        #expect(viewModel.state.secondsElapsed > initialSeconds)
    }

    @MainActor @Test("Win stops timer")
    func winStopsTimer() async throws {
        let mockStore = MockBestTimesStore()
        let mockSound = MockSoundFxManager()
        let viewModel = GameViewModel(n: 4, bestTimesStore: mockStore, soundFxManager: mockSound) { _, _ in }

        viewModel.handle(.onAppear) // Start timer
        // Wait a bit for timer
        try await Task.sleep(nanoseconds: 1_100_000_000) // 1.1 seconds

        let secondsBeforeWin = viewModel.state.secondsElapsed

        // Valid 4x4 solution
        viewModel.handle(.toggleQueen(row: 0, col: 1))
        viewModel.handle(.toggleQueen(row: 1, col: 3))
        viewModel.handle(.toggleQueen(row: 2, col: 0))
        viewModel.handle(.toggleQueen(row: 3, col: 2))

        // Wait for validation
        try await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds

        // Wait a bit more - timer should not increment after win
        try await Task.sleep(nanoseconds: 1_100_000_000) // 1.1 seconds

        // Timer should not have incremented after win
        #expect(viewModel.state.secondsElapsed == secondsBeforeWin)
    }
}
