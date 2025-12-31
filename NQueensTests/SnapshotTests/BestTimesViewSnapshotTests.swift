//
//  BestTimesViewSnapshotTests.swift
//  NQueensTests
//
//  Created by Enrique Bermúdez on 20/12/25.
//

import SnapshotTesting
import SwiftUI
import XCTest
@testable import NQueens

@MainActor
final class BestTimesViewSnapshotTests: XCTestCase {
    func testBestTimesViewEmpty() throws {
        let store = MockBestTimesStore()
        let viewModel = BestTimesViewModel(store: store)

        let view = BestTimesView(viewModel: viewModel)

        let hostingController = UIHostingController(rootView: view)
        hostingController.view.frame = CGRect(x: 0, y: 0, width: 390, height: 844)

        assertSnapshot(of: hostingController, as: .image, named: "empty")
    }

    func testBestTimesViewWithTimes() throws {
        let store = MockBestTimesStore()
        store.storedTimes = [
            BestTime(n: 4, seconds: 30, date: Date(timeIntervalSince1970: 1_704_067_200)),
            BestTime(n: 6, seconds: 60, date: Date(timeIntervalSince1970: 1_704_070_800)),
            BestTime(n: 8, seconds: 120, date: Date(timeIntervalSince1970: 1_704_074_400)),
        ]

        let viewModel = BestTimesViewModel(store: store)

        let view = BestTimesView(viewModel: viewModel)

        let hostingController = UIHostingController(rootView: view)
        hostingController.view.frame = CGRect(x: 0, y: 0, width: 390, height: 844)

        assertSnapshot(of: hostingController, as: .image, named: "withTimes")
    }
}
