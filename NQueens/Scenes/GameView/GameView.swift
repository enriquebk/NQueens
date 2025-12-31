//
//  GameView.swift
//  NQueens
//
//  Created by Enrique Bermúdez on 19/12/25.
//

import SwiftUI

struct GameView: ViewProtocol {
    @ObservedObject var viewModel: GameViewModel

    var body: some View {
        ZStack {
            DesignSystem.Colors.bg.ignoresSafeArea()
            VStack(spacing: DesignSystem.Spacing.medium) {
                header
                ChessboardView(
                    n: state.n,
                    queens: state.queens,
                    conflicts: state.conflicts,
                    onTapCell: { row, col in
                        handle(.toggleQueen(row: row, col: col))
                    }
                )
                HStack {
                    Button(L10n.GameView.resetButton) {
                        handle(.reset)
                    }
                    .buttonStyle(.reset)
                    Spacer()
                }
                Spacer().frame(height: DesignSystem.Spacing.contentButtonPadding)
            }
            .padding(.horizontal, DesignSystem.Spacing.medium)
        }
        .navigationTitle(L10n.GameView.boardSize(viewModel.state.n))
        .onAppear {
            handle(.onAppear)
        }
    }

    private var header: some View {
        HStack {
            Label {
                Text(state.secondsElapsedString)
                    .monoSmallStyle()
                    .monospacedDigit()
            } icon: {
                Image.clockIcon
                    .foregroundStyle(DesignSystem.Colors.secondary)
            }
            Spacer()
            Label {
                Text(L10n.GameView.queensLeft(state.queensLeft))
                    .subheadingStyle()
            } icon: {
                Image.queenIcon
                    .foregroundStyle(DesignSystem.Colors.secondary)
            }
        }
    }
}
