//
//  Models.swift
//  NQueens
//
//  Created by Enrique Bermúdez on 19/12/25.
//

import Foundation

typealias QueenPosition = BoardPosition

struct BoardPosition: Hashable {
    let row: Int
    let col: Int
}

struct GameState {
    let n: Int
    let queens: Set<QueenPosition>
}

struct ValidationResult: Equatable {
    let conflictingQueens: Set<QueenPosition>
    let isSolved: Bool
}

enum NQueensValidator {
    static func validate(game: GameState) -> ValidationResult {
        guard game.n >= 4 else { return .init(conflictingQueens: game.queens, isSolved: false) }

        // Map line -> queens on that line
        var rowMap: [Int: [QueenPosition]] = [:]
        var colMap: [Int: [QueenPosition]] = [:]
        var d1Map: [Int: [QueenPosition]] = [:] // r - c
        var d2Map: [Int: [QueenPosition]] = [:] // r + c

        for q in game.queens {
            rowMap[q.row, default: []].append(q)
            colMap[q.col, default: []].append(q)
            d1Map[q.row - q.col, default: []].append(q)
            d2Map[q.row + q.col, default: []].append(q)
        }

        func collectConflicts(_ map: [Int: [QueenPosition]]) -> Set<QueenPosition> {
            var conflicts = Set<QueenPosition>()
            for (_, qs) in map where qs.count > 1 {
                qs.forEach { conflicts.insert($0) }
            }
            return conflicts
        }

        let conflicting =
            collectConflicts(rowMap)
                .union(collectConflicts(colMap))
                .union(collectConflicts(d1Map))
                .union(collectConflicts(d2Map))

        let solved = (game.queens.count == game.n) && conflicting.isEmpty
        return .init(conflictingQueens: conflicting, isSolved: solved)
    }
}
