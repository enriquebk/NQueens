//
//  ChessboardView.swift
//  NQueens
//
//  Created by Enrique Bermúdez on 20/12/25.
//

import SwiftUI

struct ChessboardView: View {
    let n: Int
    let queens: Set<QueenPosition>
    let conflicts: Set<QueenPosition>
    let onTapCell: (Int, Int) -> Void

    var body: some View {
        GeometryReader { geo in
            let size = min(geo.size.width, geo.size.height)
            let cell = size / CGFloat(n)

            LazyVGrid(columns: Array(repeating: GridItem(.fixed(cell), spacing: 0), count: n), spacing: 0) {
                ForEach(0..<n*n, id: \.self) { idx in
                    let r = idx / n
                    let c = idx % n
                    let pos = QueenPosition(row: r, col: c)
                    CellView(
                        isDark: (r + c) % 2 == 1,
                        hasQueen: queens.contains(pos),
                        isConflictingQueen: conflicts.contains(pos)
                    )
                    .accessibilityLabel(String.accessibilityLabelFor(n: n, row: r, column: c))
                    .frame(width: cell, height: cell)
                    .onTapGesture { onTapCell(r, c) }
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: DesignSystem.Radius.small))
        }
        .aspectRatio(1, contentMode: .fit)
    }

    private struct CellView: View {
        let isDark: Bool
        let hasQueen: Bool
        let isConflictingQueen: Bool

        var body: some View {
            GeometryReader { geo in
                let cellSize = min(geo.size.width, geo.size.height)
                ZStack {
                    isDark ? DesignSystem.Colors.boardDark : DesignSystem.Colors.boardLight
                    if hasQueen {
                        Image.queen
                            .resizable()
                            .scaledToFit()
                            .frame(width: cellSize * 0.75, height: cellSize * 0.75)
                            .foregroundStyle(isConflictingQueen ? DesignSystem.Colors.conflict : DesignSystem.Colors.text)
                    }
                    if isConflictingQueen {
                        Color.red.opacity(0.5)
                    }
                }
            }
        }
    }
}
