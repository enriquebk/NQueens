//
//  Card.swift
//  NQueens
//
//  Created by Enrique Bermúdez on 22/12/25.
//

import SwiftUI

struct Card<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(DesignSystem.Spacing.medium)
            .background(DesignSystem.Colors.card)
            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.large, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: DesignSystem.Radius.large, style: .continuous)
                    .stroke(DesignSystem.Colors.stroke)
            )
    }
}
