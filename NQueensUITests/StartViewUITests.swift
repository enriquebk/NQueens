//
//  StartViewUITests.swift
//  NQueensUITests
//
//  Created by Enrique Bermúdez on 20/12/25.
//

import XCTest

final class StartViewUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testStartViewElementsExist() throws {
        // Verify title exists (using localized string)
        let title = app.staticTexts[L10n.StartView.title]
        XCTAssertTrue(title.exists, "Title should exist")

        // Verify subtitle exists
        let subtitle = app.staticTexts[L10n.StartView.subtitle]
        XCTAssertTrue(subtitle.exists, "Subtitle should exist")

        // Verify board size label exists
        let boardSizeLabel = app.staticTexts[L10n.StartView.boardSizeLabel]
        XCTAssertTrue(boardSizeLabel.exists, "Board size label should exist")

        // Verify minimum size label exists
        let minimumSizeLabel = app.staticTexts[L10n.StartView.minimumSizeLabel]
        XCTAssertTrue(minimumSizeLabel.exists, "Minimum size label should exist")

        // Verify NPickerView exists (should have stepper buttons and value display)
        // The picker should show the current value (default is 8)
        let pickerValue = app.staticTexts["8"]
        XCTAssertTrue(pickerValue.exists, "NPickerView should show current value")

        // Verify start game button exists
        let startButton = app.buttons[L10n.StartView.startGameButton]
        XCTAssertTrue(startButton.exists, "Start game button should exist")

        // Verify best times button exists
        let bestTimesButton = app.buttons[L10n.StartView.bestTimesButton]
        XCTAssertTrue(bestTimesButton.exists, "Best times button should exist")
    }

    func testStartGameWithValidInput() throws {
        // NPickerView should default to 8, so we can just start
        let startButton = app.buttons[L10n.StartView.startGameButton]
        startButton.tap()

        // Should navigate to game view
        // Verify navigation title shows board size
        let navTitle = app.navigationBars.staticTexts[L10n.GameView.boardSize(8)]
        XCTAssertTrue(navTitle.waitForExistence(timeout: 2), "Should navigate to game view")
    }

    func testStartGamePickerInteraction() throws {
        // Verify initial value is 8
        let initialValue = app.staticTexts["8"]
        XCTAssertTrue(initialValue.waitForExistence(timeout: 1), "Initial value should be 8")

        // Tap minus button to decrease value
        let minus = app.buttons["-"]
        XCTAssertTrue(minus.waitForExistence(timeout: 1), "Minus button should exist")
        minus.tap()

        // Value should now be 7
        let valueAfterMinus = app.staticTexts["7"]
        XCTAssertTrue(valueAfterMinus.waitForExistence(timeout: 1), "Value should be 7 after tapping minus")

        // Tap plus button to increase value
        let plus = app.buttons["+"]
        XCTAssertTrue(plus.waitForExistence(timeout: 1), "Plus button should exist")
        plus.tap()

        // Value should be back to 8
        let valueAfterPlus = app.staticTexts["8"]
        XCTAssertTrue(valueAfterPlus.waitForExistence(timeout: 1), "Value should be 8 again after tapping plus")
    }

    func testBestTimesNavigation() throws {
        let bestTimesButton = app.buttons[L10n.StartView.bestTimesButton]
        bestTimesButton.tap()

        // Should navigate to best times view
        let navTitle = app.navigationBars.staticTexts[L10n.BestTimesView.navigationTitle]
        XCTAssertTrue(navTitle.waitForExistence(timeout: 2), "Should navigate to best times view")
    }
}
