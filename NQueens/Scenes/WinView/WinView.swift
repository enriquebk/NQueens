//
//  WinView.swift
//  NQueens
//
//  Created by Enrique Bermúdez on 19/12/25.
//

import Lottie
import SwiftUI

struct WinView: View {
    let seconds: Int
    let n: Int
    let onBackToStart: () -> Void

    var body: some View {
        ZStack {
            LottieView(animation: .confetti)
                .playing(loopMode: .loop)
                .opacity(0.6)
                .ignoresSafeArea()

            VStack(spacing: DesignSystem.Spacing.medium) {
                VStack(spacing: DesignSystem.Spacing.small) {
                    Text(L10n.WinView.title)
                        .titleStyle()

                    VStack(spacing: DesignSystem.Spacing.xsmall) {
                        Text(L10n.WinView.boardSize(n))
                            .headingStyle()

                        Text(L10n.WinView.time(seconds.formattedTimeMMSS()))
                            .monoStyle()
                            .monospacedDigit()
                    }
                }

                Button(L10n.WinView.backToStartButton) { onBackToStart() }
                    .buttonStyle(.primary)

                Spacer().frame(height: DesignSystem.Spacing.contentButtonPadding)
            }
            .padding(.horizontal, DesignSystem.Spacing.medium)
        }
        .background(DesignSystem.Colors.bg)
        .navigationBarBackButtonHidden(true)
    }
}
