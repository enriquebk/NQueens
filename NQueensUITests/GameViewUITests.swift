//
//  GameViewUITests.swift
//  NQueensUITests
//
//  Created by Enrique Bermúdez on 20/12/25.
//

import XCTest

final class GameViewUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testGameViewElementsExist() throws {
        let n = 4
        // Navigate to game view
        UITestHelper.navigateToGame(n: n, inside: app)

        // Verify navigation title
        let navTitle = app.navigationBars.staticTexts[L10n.GameView.boardSize(n)]
        XCTAssertTrue(navTitle.waitForExistence(timeout: 2), "Navigation title should show board size")

        // Verify time label exists (should show formatted time like "00:00")
        // The time is displayed as a formatted string, so we check for the pattern
        let timeLabel = app.staticTexts.matching(NSPredicate(format: "label MATCHES '^[0-9]{2}:[0-9]{2}$'"))
        XCTAssertTrue(timeLabel.firstMatch.exists, "Time label should exist")

        // Verify queens left label exists
        let queensLabel = app.staticTexts.containing(NSPredicate(format: "label CONTAINS '\(L10n.GameView.queensLeft(n))'"))
        XCTAssertTrue(queensLabel.firstMatch.exists, "Queens left label should exist")

        // Verify reset button exists
        let resetButton = app.buttons[L10n.GameView.resetButton]
        XCTAssertTrue(resetButton.exists, "Reset button should exist")
    }

    func testTapCellTogglesQueen() throws {
        UITestHelper.navigateToGame(n: 4, inside: app)

        // Tap first cell using accessibilityLabel
        let cell = app.otherElements["1a"]
        XCTAssertTrue(cell.waitForExistence(timeout: 2), "Cell should exist")
        cell.tap()

        // Wait for queen to be placed
        sleep(1)

        // Verify queens left decreased from 4 to 3
        let queensLabel = app.staticTexts.containing(NSPredicate(format: "label CONTAINS '\(L10n.GameView.queensLeft(3))'"))
        XCTAssertTrue(queensLabel.firstMatch.waitForExistence(timeout: 2), "Queens left should decrease after placing a queen")
    }

    func testResetButton() throws {
        let n = 4
        UITestHelper.navigateToGame(n: n, inside: app)

        // Place a queen first by tapping on a cell
        let cell = app.otherElements["1a"]
        XCTAssertTrue(cell.waitForExistence(timeout: 2), "Cell should exist")
        cell.tap()

        // Wait for queen to be placed
        sleep(1)

        // Verify queens left decreased
        let queensLabelBefore = app.staticTexts.containing(NSPredicate(format: "label CONTAINS '\(L10n.GameView.queensLeft(n-1))'"))
        XCTAssertTrue(queensLabelBefore.firstMatch.waitForExistence(timeout: 2), "Queens left should decrease after placing a queen")

        // Tap reset button
        let resetButton = app.buttons[L10n.GameView.resetButton]
        resetButton.tap()

        // After reset, queens left should be back to 4 (for a 4x4 board)
        let queensLabelAfter = app.staticTexts.containing(NSPredicate(format: "label CONTAINS '\(L10n.GameView.queensLeft(n))'"))
        XCTAssertTrue(queensLabelAfter.firstMatch.waitForExistence(timeout: 2), "Queens left should be reset to 4")
    }
}
