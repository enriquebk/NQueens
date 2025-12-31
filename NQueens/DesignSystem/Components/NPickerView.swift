//
//  NPickerView.swift
//  NQueens
//
//  Created by Enrique Bermúdez on 21/12/25.
//

import SwiftUI

struct NPickerView: View {
    @Binding var value: Int
    let minValue = 4
    let maxValue: Int

    init(value: Binding<Int>, maxValue: Int = 20) {
        _value = value
        self.maxValue = maxValue
    }

    var body: some View {
        HStack(spacing: DesignSystem.Spacing.small) {
            StepperButton(symbol: .minus) {
                value = max(minValue, value - 1)
            }

            Text("\(value)")
                .foregroundStyle(DesignSystem.Colors.text)
                .frame(maxWidth: .infinity, minHeight: 40)
                .background(Color.black.opacity(0.03))
                .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.small, style: .continuous))

            StepperButton(symbol: .plus) {
                value = min(maxValue, value + 1)
            }
        }
    }
}

private struct StepperButton: View {
    let symbol: ButtonSymbol
    let action: () -> Void

    private var image: Image { symbol == .minus ? .minus : .plus }

    enum ButtonSymbol {
        case minus
        case plus
    }

    var body: some View {
        Button(action: action) {
            image
                .accessibilityLabel(symbol == .minus ? "-" : "+")
                .foregroundStyle(DesignSystem.Colors.accentDark)
                .frame(width: 44, height: 40)
                .background(Color.black.opacity(0.03))
                .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.small, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}
