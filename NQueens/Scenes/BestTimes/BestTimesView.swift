//
//  BestTimesView.swift
//  NQueens
//
//  Created by Enrique Bermúdez on 19/12/25.
//

import SwiftUI

struct BestTimesView: ViewProtocol {
    @StateObject var viewModel: BestTimesViewModel

    var body: some View {
        ZStack {
            DesignSystem.Colors.bg.ignoresSafeArea()

            if state.items.isEmpty {
                VStack {
                    Card {
                        Text(L10n.BestTimesView.emptyStateMessage)
                    }
                    .padding(.horizontal, DesignSystem.Spacing.medium)
                    .padding(.top, DesignSystem.Spacing.large)
                    Spacer()
                }
            } else {
                List {
                    Section {
                        ForEach(state.items.indices, id: \.self) { idx in
                            BestTimeRow(rank: idx + 1, item: state.items[idx])
                                .listRowBackground(
                                    RoundedRectangle(cornerRadius: DesignSystem.Radius.medium, style: .continuous)
                                        .fill(DesignSystem.Colors.card)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: DesignSystem.Radius.medium, style: .continuous)
                                                .stroke(DesignSystem.Colors.stroke)
                                        )
                                        .padding(.vertical, DesignSystem.Spacing.xsmall)
                                )
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .scrollContentBackground(.hidden)
                .background(DesignSystem.Colors.bg)
            }
        }
        .navigationTitle(L10n.BestTimesView.navigationTitle)
        .tint(DesignSystem.Colors.accentDark)
        .onAppear {
            handle(.onAppear)
        }
    }
}

struct BestTimeRow: View {
    let rank: Int
    let item: BestTime

    var body: some View {
        HStack(alignment: .top, spacing: DesignSystem.Spacing.medium) {
            rankChip
            VStack(alignment: .leading, spacing: DesignSystem.Spacing.xsmall) {
                Text(L10n.BestTimesView.boardSize(item.n))
                    .headingStyle()

                Text(item.seconds.formattedTimeMMSS())
                    .monoStyle()
                    .monospacedDigit()
            }
            Spacer()
            VStack(alignment: .trailing, spacing: DesignSystem.Spacing.medium) {
                Text(item.date.formattedDate())
                    .smallStyle()
                Text(item.date.formattedTime())
                    .smallStyle()
            }
        }
        .padding(.vertical, DesignSystem.Spacing.small)
    }

    var rankChip: some View {
        Text(L10n.BestTimesView.rank(rank))
            .font(DesignSystem.Typography.subheading)
            .foregroundStyle(.white)
            .padding(.horizontal, DesignSystem.Spacing.small)
            .padding(.vertical, DesignSystem.Spacing.xsmall)
            .background(DesignSystem.Colors.accentDark)
            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.xsmall, style: .continuous))
    }
}
