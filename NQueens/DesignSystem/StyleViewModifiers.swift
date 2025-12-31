//
//  StyleViewModifiers.swift
//  NQueens
//
//  Created by Enrique Bermúdez on 22/12/25.
//

import SwiftUI

// MARK: - Text Style Modifiers

struct HeaderTitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(DesignSystem.Typography.bigTitle)
            .foregroundStyle(DesignSystem.Colors.accentDark)
    }
}

struct TitleStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(DesignSystem.Typography.title)
            .foregroundStyle(DesignSystem.Colors.accentDark)
    }
}

struct HeadingStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(DesignSystem.Typography.heading)
            .foregroundStyle(DesignSystem.Colors.text)
    }
}

struct SubheadingStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(DesignSystem.Typography.subheading)
            .foregroundStyle(DesignSystem.Colors.text)
    }
}

struct BodyStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(DesignSystem.Typography.body)
            .foregroundStyle(DesignSystem.Colors.secondary)
    }
}

struct CaptionStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(DesignSystem.Typography.caption)
            .foregroundStyle(DesignSystem.Colors.secondary)
    }
}

struct SmallStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(DesignSystem.Typography.small)
            .foregroundStyle(DesignSystem.Colors.secondary)
    }
}

struct MonoStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(DesignSystem.Typography.mono)
            .foregroundStyle(DesignSystem.Colors.text)
    }
}

struct MonoSmallStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(DesignSystem.Typography.monoSmall)
            .foregroundStyle(DesignSystem.Colors.text)
    }
}

// MARK: - View Extensions

public extension View {
    func headerTitleStyle() -> some View {
        modifier(HeaderTitleStyle())
    }

    func titleStyle() -> some View {
        modifier(TitleStyle())
    }

    func headingStyle() -> some View {
        modifier(HeadingStyle())
    }

    func subheadingStyle() -> some View {
        modifier(SubheadingStyle())
    }

    func bodyStyle() -> some View {
        modifier(BodyStyle())
    }

    func captionStyle() -> some View {
        modifier(CaptionStyle())
    }

    func smallStyle() -> some View {
        modifier(SmallStyle())
    }

    func monoStyle() -> some View {
        modifier(MonoStyle())
    }

    func monoSmallStyle() -> some View {
        modifier(MonoSmallStyle())
    }
}
