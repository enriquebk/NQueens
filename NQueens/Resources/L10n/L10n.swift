//
//  L10n.swift
//  NQueens
//
//  Created by Enrique Bermúdez on 20/12/25.
//

import Foundation

enum L10n {
    public enum StartView {
        static var title: String { String(localized: "N-Queens") }
        static var subtitle: String { String(localized: "Place N queens so none attack") }
        static var boardSizeLabel: String { String(localized: "Board size") }
        static var minimumSizeLabel: String { String(localized: "Minimum size: 4×4") }
        static var startGameButton: String { String(localized: "Start Game") }
        static var bestTimesButton: String { String(localized: "Best Times") }
    }

    public enum GameView {
        static func boardSize(_ n: Int) -> String {
            String.localizedStringWithFormat(String(localized: "%lld×%lld"), n, n)
        }

        static func queensLeft(_ count: Int) -> String {
            String.localizedStringWithFormat(String(localized: "Queens left: %lld"), count)
        }

        static var resetButton: String { String(localized: "Reset") }
    }

    enum BestTimesView {
        static var navigationTitle: String { String(localized: "Best Times") }
        static var emptyStateMessage: String { String(localized: "No times yet. Solve a board to set a record.") }
        static func rank(_ number: Int) -> String {
            String.localizedStringWithFormat(String(localized: "#%lld"), number)
        }

        static func boardSize(_ n: Int) -> String {
            String.localizedStringWithFormat(String(localized: "%lldx%lld"), n, n)
        }
    }

    enum WinView {
        static var title: String { String(localized: "You won! 🎉") }
        static func boardSize(_ n: Int) -> String {
            String.localizedStringWithFormat(String(localized: "Board: %lld×%lld"), n, n)
        }

        static func time(_ timeString: String) -> String {
            String.localizedStringWithFormat(String(localized: "Time: %@"), timeString)
        }

        static var backToStartButton: String { String(localized: "Back to Start") }
    }
}
