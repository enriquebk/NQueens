//
//  WinViewSnapshotTests.swift
//  NQueensTests
//
//  Created by Enrique Bermúdez on 20/12/25.
//

import SnapshotTesting
import SwiftUI
import XCTest
@testable import NQueens

@MainActor
final class WinViewSnapshotTests: XCTestCase {
    func testWinView() throws {
        let view = WinView(
            seconds: 125,
            n: 8,
            onBackToStart: {}
        )

        let hostingController = UIHostingController(rootView: view)
        hostingController.view.frame = CGRect(x: 0, y: 0, width: 390, height: 844)

        assertSnapshot(of: hostingController, as: .image)
    }
}
