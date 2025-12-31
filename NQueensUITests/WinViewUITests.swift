//
//  WinViewUITests.swift
//  NQueensUITests
//
//  Created by Enrique Bermúdez on 20/12/25.
//

import XCTest

final class WinViewUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testWinViewElementsExist() throws {
        UITestHelper.navigateToWin(n: 4, inside: app)

        let title = app.staticTexts[L10n.WinView.title]
        XCTAssertTrue(title.waitForExistence(timeout: 5), "Win title should exist")

        let boardSize = app.staticTexts[L10n.WinView.boardSize(4)]
        XCTAssertTrue(boardSize.waitForExistence(timeout: 2), "Board size label should exist")

        // Time format is "Time: MM:SS", check for pattern
        let timePattern = NSPredicate(format: "label BEGINSWITH 'Time: '")
        let timeLabel = app.staticTexts.matching(timePattern).firstMatch
        XCTAssertTrue(timeLabel.waitForExistence(timeout: 2), "Time label should exist")

        let backButton = app.buttons[L10n.WinView.backToStartButton]
        XCTAssertTrue(backButton.waitForExistence(timeout: 2), "Back to Start button should exist")
    }

    func testBackToStartButtonNavigates() throws {
        UITestHelper.navigateToWin(n: 6, inside: app)
        let backButton = app.buttons[L10n.WinView.backToStartButton]
        XCTAssertTrue(backButton.waitForExistence(timeout: 2), "Back button should exist")
        backButton.tap()

        let startButton = app.buttons[L10n.StartView.startGameButton]
        XCTAssertTrue(startButton.waitForExistence(timeout: 3), "Should navigate back to Start View")
    }
}
