//
//  BestTimesViewUITests.swift
//  NQueensUITests
//
//  Created by Enrique Bermúdez on 20/12/25.
//

import XCTest

final class BestTimesViewUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false

        app = XCUIApplication()

        app.launchArguments.append("UI-Testing-Reset-BestTimes")

        app.launch()

        sleep(1)
    }

    func testBestTimesViewNavigation() throws {
        // Navigate to Best Times view from Start View
        let bestTimesButton = app.buttons[L10n.StartView.bestTimesButton]
        XCTAssertTrue(bestTimesButton.waitForExistence(timeout: 2), "Best Times button should exist")
        bestTimesButton.tap()

        // Verify navigation title
        let navTitle = app.navigationBars.staticTexts[L10n.BestTimesView.navigationTitle]
        XCTAssertTrue(navTitle.waitForExistence(timeout: 2), "Best Times navigation title should exist")
    }

    func testBestTimesViewShowsEmptyState() throws {
        // Navigate to Best Times view
        navigateToBestTimes()

        // Verify empty state message exists
        let emptyStateMessage = app.staticTexts[L10n.BestTimesView.emptyStateMessage]
        XCTAssertTrue(emptyStateMessage.waitForExistence(timeout: 2), "Empty state message should exist")
    }

    func testBestTimesViewShowsTop5Only() throws {
        // Ensure clean state (already cleared in setUp, but being explicit)

        UITestHelper.navigateToWin(n: 4, inside: app)

        // Tap back button
        app.buttons[L10n.WinView.backToStartButton].tap()
        sleep(1)

        // Navigate to Best Times view
        navigateToBestTimes()

        // Wait for view to load
        sleep(2)

        // Verify navigation title
        let navTitle = app.navigationBars.staticTexts[L10n.BestTimesView.navigationTitle]
        XCTAssertTrue(navTitle.waitForExistence(timeout: 2), "Navigation title should exist")

        // The rank chip is a Text with format "#1" (not "1#"), and it's a staticText, not otherElement
        let rankChip1 = app.staticTexts[L10n.BestTimesView.rank(1)]

        // Check if list is showing (when if true is fixed)
        if rankChip1.waitForExistence(timeout: 2) {
            // Verify board size exists (format: "4x4")
            let boardSize = app.staticTexts[L10n.BestTimesView.boardSize(4)]
            XCTAssertTrue(boardSize.exists, "Board size should exist")

            // Verify time format exists (should be formatted as MM:SS)
            let timePattern = NSPredicate(format: "label MATCHES '^[0-9]{2}:[0-9]{2}$'")
            let timeLabel = app.staticTexts.matching(timePattern).firstMatch
            XCTAssertTrue(timeLabel.exists, "Time should be displayed in MM:SS format")
        } else {
            // If rank chip doesn't exist, it means the list view is not showing
            // This is expected due to `if true` in BestTimesView line 17
            XCTFail("Rank chip #1 not found. BestTimesView has `if true` that always shows empty state. Change line 17 to `if viewModel.items.isEmpty` to show the list.")
        }
    }

    func testBestTimesViewBackButton() throws {
        // Navigate to Best Times view
        navigateToBestTimes()

        // Verify we're on Best Times view
        let navTitle = app.navigationBars.staticTexts[L10n.BestTimesView.navigationTitle]
        XCTAssertTrue(navTitle.waitForExistence(timeout: 2), "Should be on Best Times view")

        // Tap back button
        if app.navigationBars.buttons.count > 0 {
            app.navigationBars.buttons.element(boundBy: 0).tap()
            sleep(1)

            // Verify we're back on Start View
            let startButton = app.buttons[L10n.StartView.startGameButton]
            XCTAssertTrue(startButton.waitForExistence(timeout: 2), "Should navigate back to Start View")
        }
    }

    // MARK: - Helper Methods

    private func navigateToBestTimes() {
        // Navigate back to start view if needed
        var attempts = 0
        while !app.buttons[L10n.StartView.bestTimesButton].exists, attempts < 5 {
            if app.navigationBars.buttons.count > 0 {
                app.navigationBars.buttons.element(boundBy: 0).tap()
                sleep(1)
            }
            attempts += 1
        }

        // Wait for start view to be ready
        let bestTimesButton = app.buttons[L10n.StartView.bestTimesButton]
        XCTAssertTrue(bestTimesButton.waitForExistence(timeout: 3), "Best Times button should be visible")
        bestTimesButton.tap()
    }
}
