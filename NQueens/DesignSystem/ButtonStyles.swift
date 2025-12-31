//
//  ButtonStyles.swift
//  NQueens
//
//  Created by Enrique Bermúdez on 22/12/25.
//

import SwiftUI

public enum ButtonStyles {
    case primary
    case secondary
    case reset
}

extension Button {
    @ViewBuilder
    public func buttonStyle(_ style: ButtonStyles) -> some View {
        switch style {
        case .primary:
            buttonStyle(PrimaryButtonStyle())
        case .secondary:
            buttonStyle(SecondaryButtonStyle())
        case .reset:
            buttonStyle(ResetButtonStyle())
        }
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(DesignSystem.Typography.subheading)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, minHeight: 52)
            .background(DesignSystem.Colors.accent)
            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.large, style: .continuous))
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.99 : 1.0)
            .shadow(color: .black.opacity(0.08), radius: 10, y: 6)
    }
}

struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(DesignSystem.Typography.subheading)
            .foregroundStyle(DesignSystem.Colors.accentDark)
            .frame(maxWidth: .infinity, minHeight: 44)
            .background(DesignSystem.Colors.card)
            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.large, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: DesignSystem.Radius.large, style: .continuous)
                    .stroke(DesignSystem.Colors.accentDark.opacity(0.35))
            )
            .opacity(configuration.isPressed ? 0.85 : 1.0)
    }
}

struct ResetButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(DesignSystem.Typography.subheading)
            .foregroundStyle(DesignSystem.Colors.text)
            .padding(.horizontal, DesignSystem.Spacing.large)
            .padding(.vertical, DesignSystem.Spacing.small)
            .frame(minHeight: 44)
            .background(DesignSystem.Colors.card)
            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.medium, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: DesignSystem.Radius.medium, style: .continuous)
                    .stroke(DesignSystem.Colors.stroke)
            )
            .opacity(configuration.isPressed ? 0.9 : 1.0)
    }
}
