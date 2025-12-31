//
//  DesignSystem.swift
//  NQueens
//
//  Created by Enrique Bermúdez on 19/12/25.
//

import SwiftUI

enum DesignSystem {
    enum Colors {
        // Backgrounds
        static let bg = Color(red: 0.96, green: 0.97, blue: 0.97)
        static let card = Color.white
        static let stroke = Color.black.opacity(0.08)

        // Text
        static let text = Color(red: 0.12, green: 0.12, blue: 0.12)
        static let secondary = Color.black.opacity(0.55)

        // Accent colors
        static let accent = Color(red: 0.50, green: 0.65, blue: 0.31) // green
        static let accentDark = Color(red: 0.40, green: 0.55, blue: 0.27) // greenDark

        // Board colors
        static let boardLight = Color(red: 0.93, green: 0.93, blue: 0.82) // #EEEED2
        static let boardDark = Color(red: 0.46, green: 0.59, blue: 0.34) // #769656

        // Status colors
        static let conflict = Color(.systemRed)
    }

    enum Spacing {
        static let xsmall: CGFloat = 6
        static let small: CGFloat = 10
        static let medium: CGFloat = 16
        static let large: CGFloat = 32
        static let contentButtonPadding: CGFloat = 128
    }

    enum Radius {
        static let xsmall: CGFloat = 8
        static let small: CGFloat = 10
        static let medium: CGFloat = 14
        static let large: CGFloat = 16
    }

    enum Typography {
        static let bigTitle = Font.system(size: 40, weight: .semibold)
        static let title = Font.system(size: 36, weight: .semibold)
        static let heading = Font.system(size: 18, weight: .semibold)
        static let subheading = Font.system(size: 16, weight: .semibold)
        static let body = Font.system(size: 16, weight: .regular)
        static let caption = Font.system(size: 14, weight: .semibold)
        static let small = Font.system(size: 13, weight: .regular)
        static let mono = Font.system(size: 18, weight: .semibold, design: .monospaced)
        static let monoSmall = Font.system(size: 16, weight: .semibold, design: .monospaced)
    }
}
