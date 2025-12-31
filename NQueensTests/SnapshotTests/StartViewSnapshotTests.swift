//
//  StartViewSnapshotTests.swift
//  NQueensTests
//
//  Created by Enrique Bermúdez on 20/12/25.
//

import SnapshotTesting
import SwiftUI
import XCTest
@testable import NQueens

@MainActor
final class StartViewSnapshotTests: XCTestCase {
    func testStartView() throws {
        let view = StartView(
            onStart: { _ in },
            onBestTimes: {}
        )

        let hostingController = UIHostingController(rootView: view)
        hostingController.view.frame = CGRect(x: 0, y: 0, width: 390, height: 844)

        assertSnapshot(of: hostingController, as: .image)
    }
}
