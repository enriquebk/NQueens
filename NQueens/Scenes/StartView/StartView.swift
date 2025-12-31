//
//  StartView.swift
//  NQueens
//
//  Created by Enrique Bermúdez on 19/12/25.
//

import SwiftUI

struct StartView: View {
    @State private var n = 8

    let onStart: (Int) -> Void
    let onBestTimes: () -> Void

    var body: some View {
        ZStack {
            DesignSystem.Colors.bg.ignoresSafeArea()

            VStack(spacing: DesignSystem.Spacing.medium) {
                Spacer().frame(height: DesignSystem.Spacing.large)

                VStack(spacing: DesignSystem.Spacing.small) {
                    Text(L10n.StartView.title)
                        .headerTitleStyle()

                    Text(L10n.StartView.subtitle)
                        .bodyStyle()
                }

                Card {
                    VStack(alignment: .leading, spacing: DesignSystem.Spacing.small) {
                        Text(L10n.StartView.boardSizeLabel)
                            .captionStyle()

                        NPickerView(value: $n)

                        Text(L10n.StartView.minimumSizeLabel)
                            .smallStyle()
                    }
                }

                Button(L10n.StartView.startGameButton) { onStart(n) }
                    .buttonStyle(.primary)

                Button(L10n.StartView.bestTimesButton) { onBestTimes() }
                    .buttonStyle(.secondary)

                Spacer()
            }
            .padding(.horizontal, DesignSystem.Spacing.medium)
        }
    }
}
