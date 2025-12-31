//
//  GameViewModel.swift
//  NQueens
//
//  Created by Enrique Bermúdez on 19/12/25.
//

import Combine
import Foundation

// MARK: - ViewModel

final class GameViewModel: ViewModel {
    @Published var state: GameViewState

    private let bestTimesStore: BestTimesStore
    private let soundFxManager: SoundFxManager
    private var timerCancellable: AnyCancellable?
    private let onWin: (Int, Int) -> Void

    // MARK: - State

    struct GameViewState: Equatable {
        let n: Int
        var queens: Set<QueenPosition> = []
        var conflicts: Set<QueenPosition> = []
        var secondsElapsed = 0
        var isSolved = false

        var queensLeft: Int { max(0, n - queens.count) }
        var secondsElapsedString: String { secondsElapsed.formattedTimeMMSS() }
    }

    // MARK: - Events

    enum GameEvent {
        case onAppear
        case toggleQueen(row: Int, col: Int)
        case reset
        case timerTick
    }

    // MARK: - Effects

    enum GameEffect {
        case playSound
        case startTimer
        case stopTimer
        case saveTime(n: Int, seconds: Int)
        case navigateToWin(seconds: Int, n: Int)
    }

    init(
        n: Int,
        bestTimesStore: BestTimesStore,
        soundFxManager: SoundFxManager = SystemSoundFxManager(),
        onWin: @escaping (Int, Int) -> Void
    ) {
        self.state = GameViewState(n: n)
        self.onWin = onWin
        self.bestTimesStore = bestTimesStore
        self.soundFxManager = soundFxManager
    }

    // MARK: - Event Handler

    static func reduce(_ event: GameEvent, currentState: GameViewState) -> (GameViewState, [GameEffect]) {
        var newState = currentState
        var effects: [GameEffect] = []

        switch event {
        case .onAppear:
            effects.append(.startTimer)

        case let .toggleQueen(row, col):
            let pos = QueenPosition(row: row, col: col)
            if newState.queens.contains(pos) {
                newState.queens.remove(pos)
            } else {
                guard newState.n > newState.queens.count else {
                    return (newState, [])
                }
                newState.queens.insert(pos)
            }
            effects.append(.playSound)

            // Validate game
            let result = NQueensValidator.validate(game: .init(n: newState.n, queens: newState.queens))
            newState.conflicts = result.conflictingQueens

            if result.isSolved {
                newState.isSolved = true
                effects.append(.stopTimer)
                effects.append(.saveTime(n: newState.n, seconds: newState.secondsElapsed))
                effects.append(.navigateToWin(seconds: newState.secondsElapsed, n: newState.n))
            }

        case .reset:
            newState.queens.removeAll()
            newState.conflicts.removeAll()
            newState.secondsElapsed = 0
            newState.isSolved = false
            effects.append(.startTimer)

        case .timerTick:
            guard !newState.isSolved else {
                return (newState, [])
            }
            newState.secondsElapsed += 1
        }

        return (newState, effects)
    }

    // MARK: - Effect Processor

    func process(_ effect: GameEffect) {
        switch effect {
        case .playSound:
            soundFxManager.playQueenTap()

        case .startTimer:
            startTimer()

        case .stopTimer:
            stopTimer()

        case let .saveTime(n, seconds):
            bestTimesStore.recordTime(n: n, seconds: seconds)

        case let .navigateToWin(seconds, n):
            onWin(seconds, n)
        }
    }

    private func startTimer() {
        timerCancellable?.cancel()
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                self?.handle(.timerTick)
            }
    }

    private func stopTimer() {
        timerCancellable?.cancel()
        timerCancellable = nil
    }
}
