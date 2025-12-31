//
//  GameViewSnapshotTests.swift
//  NQueensTests
//
//  Created by Enrique Bermúdez on 20/12/25.
//

import SnapshotTesting
import SwiftUI
import XCTest
@testable import NQueens

@MainActor
final class GameViewSnapshotTests: XCTestCase {
    func testGameView() throws {
        let viewModel = GameViewModel(
            n: 4,
            bestTimesStore: MockBestTimesStore(),
            soundFxManager: MockSoundFxManager(),
            onWin: { _, _ in }
        )

        let view = GameView(viewModel: viewModel)

        let hostingController = UIHostingController(rootView: view)
        hostingController.view.frame = CGRect(x: 0, y: 0, width: 390, height: 844)

        assertSnapshot(of: hostingController, as: .image)
    }

    func testGameViewWithQueensNoConflict() throws {
        let viewModel = GameViewModel(
            n: 4,
            bestTimesStore: MockBestTimesStore(),
            soundFxManager: MockSoundFxManager(),
            onWin: { _, _ in }
        )

        viewModel.handle(.toggleQueen(row: 0, col: 1))
        viewModel.handle(.toggleQueen(row: 1, col: 3))

        let view = GameView(viewModel: viewModel)

        let hostingController = UIHostingController(rootView: view)
        hostingController.view.frame = CGRect(x: 0, y: 0, width: 390, height: 844)

        assertSnapshot(of: hostingController, as: .image, named: "withQueensNoConflict")
    }

    func testGameViewWithQueensConflict() throws {
        let viewModel = GameViewModel(
            n: 4,
            bestTimesStore: MockBestTimesStore(),
            soundFxManager: MockSoundFxManager(),
            onWin: { _, _ in }
        )

        // Add queens that conflict (same row)
        viewModel.handle(.toggleQueen(row: 0, col: 0))
        viewModel.handle(.toggleQueen(row: 0, col: 1))

        let view = GameView(viewModel: viewModel)

        let hostingController = UIHostingController(rootView: view)
        hostingController.view.frame = CGRect(x: 0, y: 0, width: 390, height: 844)

        assertSnapshot(of: hostingController, as: .image, named: "withQueensConflict")
    }
}
