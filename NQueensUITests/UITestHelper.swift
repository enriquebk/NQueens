//
//  Utils.swift
//  NQueens
//
//  Created by Enrique Bermúdez on 26/12/25.
//

import SwiftUI
import XCTest

enum UITestHelper {
    // MARK: - Helper Methods

    static func navigateToGame(n: Int, inside app: XCUIApplication) {
        // Navigate back to start view if needed
        var attempts = 0
        while !app.buttons[L10n.StartView.startGameButton].exists, attempts < 5 {
            if app.navigationBars.buttons.count > 0 {
                app.navigationBars.buttons.element(boundBy: 0).tap()
                sleep(1)
            }
            attempts += 1
        }

        // Wait for start view to be ready
        let startButton = app.buttons[L10n.StartView.startGameButton]
        XCTAssertTrue(startButton.waitForExistence(timeout: 3), "Start game should be visible")

        // Adjust NPickerView value if needed
        let targetValue = app.staticTexts["\(n)"]
        if !targetValue.exists, n != 8 {
            // Find current value (default is 8)
            let currentValue = app.staticTexts["8"]
            if currentValue.waitForExistence(timeout: 2) {
                if n < 8 {
                    // Need to decrease: tap minus button
                    let minusButton = app.buttons["-"]
                    XCTAssertTrue(minusButton.waitForExistence(timeout: 2), "Minus button should exist")

                    let tapsNeeded = 8 - n
                    for i in 0..<tapsNeeded {
                        minusButton.tap()
                        sleep(1)

                        // Verify value updated
                        let expectedValue = 8 - i - 1
                        let newValue = app.staticTexts["\(expectedValue)"]
                        XCTAssertTrue(newValue.waitForExistence(timeout: 1), "Value should be \(expectedValue) after tapping minus")
                    }
                } else if n > 8 {
                    // Need to increase: tap plus button
                    let plusButton = app.buttons["+"]
                    XCTAssertTrue(plusButton.waitForExistence(timeout: 2), "Plus button should exist")

                    let tapsNeeded = n - 8
                    for i in 0..<tapsNeeded {
                        plusButton.tap()
                        sleep(1)

                        // Verify value updated
                        let expectedValue = 8 + i + 1
                        let newValue = app.staticTexts["\(expectedValue)"]
                        XCTAssertTrue(newValue.waitForExistence(timeout: 1), "Value should be \(expectedValue) after tapping plus")
                    }
                }

                // Verify target value is now visible
                XCTAssertTrue(app.staticTexts["\(n)"].waitForExistence(timeout: 2), "NPickerView should show value \(n)")
            }
        }

        startButton.tap()
    }

    static func navigateToWin(n: Int, inside app: XCUIApplication) {
        // Navigate to game view
        UITestHelper.navigateToGame(n: n, inside: app)

        // Wait for game view to appear
        let navTitle = app.navigationBars.staticTexts[L10n.GameView.boardSize(n)]
        XCTAssertTrue(navTitle.waitForExistence(timeout: 5), "Game view should appear")

        // Wait a moment for the view to fully load
        sleep(1)

        // Complete the game by placing queens in valid positions
        completeGame(n: n, inside: app)

        // Wait for win view to appear (may take longer for validation)
        let winTitle = app.staticTexts[L10n.WinView.title]
        XCTAssertTrue(winTitle.waitForExistence(timeout: 10), "Win view should appear after completing game")
    }

    private static func completeGame(n: Int, inside app: XCUIApplication) {
        // Valid solution positions for different board sizes
        // These are known valid N-Queens solutions
        let validPositions4x4 = [
            (row: 0, col: 1),
            (row: 1, col: 3),
            (row: 2, col: 0),
            (row: 3, col: 2),
        ]

        let validPositions6x6 = [
            (row: 0, col: 1),
            (row: 1, col: 3),
            (row: 2, col: 5),
            (row: 3, col: 0),
            (row: 4, col: 2),
            (row: 5, col: 4),
        ]

        let validPositions8x8 = [
            (row: 0, col: 0),
            (row: 1, col: 4),
            (row: 2, col: 7),
            (row: 3, col: 5),
            (row: 4, col: 2),
            (row: 5, col: 6),
            (row: 6, col: 1),
            (row: 7, col: 3),
        ]

        let positions: [(row: Int, col: Int)]
        switch n {
        case 4:
            positions = validPositions4x4
        case 6:
            positions = validPositions6x6
        case 8:
            positions = validPositions8x8
        default:
            // For other sizes, try a simple pattern (may not be valid)
            positions = (0..<n).map { (row: $0, col: $0) }
        }

        // Wait for chessboard to be ready
        let firstCell = app.otherElements["1a"]
        XCTAssertTrue(firstCell.waitForExistence(timeout: 3), "Chessboard should be visible")

        // Tap each cell using accessibilityLabel
        for (index, position) in positions.enumerated() {
            let cellLabel: String = .accessibilityLabelFor(n: n, row: position.row, column: position.col)

            let cell = app.otherElements[cellLabel]

            XCTAssertTrue(cell.waitForExistence(timeout: 3), "Cell with label '\(cellLabel)' should exist")
            cell.tap()

            // Wait for queen to be placed and UI to update
            sleep(1)

            // After placing all queens, wait a bit longer for validation
            if index == positions.count - 1 {
                sleep(2)
            }
        }

        // Wait for game to validate and trigger win
        // The game should automatically detect the win condition
        sleep(3)
    }
}
