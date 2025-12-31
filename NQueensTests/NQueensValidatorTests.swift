//
//  NQueensValidatorTests.swift
//  NQueensTests
//
//  Created by Enrique Bermúdez on 20/12/25.
//

import Testing
@testable import NQueens

struct NQueensValidatorTests {
    // MARK: - Valid Solutions

    @Test("Valid 4x4 solution")
    func valid4x4Solution() {
        let queens: Set<QueenPosition> = [
            QueenPosition(row: 0, col: 1),
            QueenPosition(row: 1, col: 3),
            QueenPosition(row: 2, col: 0),
            QueenPosition(row: 3, col: 2),
        ]
        let gameState = GameState(n: 4, queens: queens)
        let result = NQueensValidator.validate(game: gameState)

        #expect(result.isSolved == true)
        #expect(result.conflictingQueens.isEmpty)
    }

    @Test("Valid 8x8 solution")
    func valid8x8Solution() {
        // Classic 8-queens solution
        let queens: Set<QueenPosition> = [
            QueenPosition(row: 0, col: 0),
            QueenPosition(row: 1, col: 4),
            QueenPosition(row: 2, col: 7),
            QueenPosition(row: 3, col: 5),
            QueenPosition(row: 4, col: 2),
            QueenPosition(row: 5, col: 6),
            QueenPosition(row: 6, col: 1),
            QueenPosition(row: 7, col: 3),
        ]
        let gameState = GameState(n: 8, queens: queens)
        let result = NQueensValidator.validate(game: gameState)

        #expect(result.isSolved == true)
        #expect(result.conflictingQueens.isEmpty)
    }

    // MARK: - Invalid Solutions

    @Test("Same row conflict")
    func sameRowConflict() {
        let queens: Set<QueenPosition> = [
            QueenPosition(row: 0, col: 0),
            QueenPosition(row: 0, col: 1),
        ]
        let gameState = GameState(n: 4, queens: queens)
        let result = NQueensValidator.validate(game: gameState)

        #expect(result.isSolved == false)
        #expect(result.conflictingQueens.count == 2)
        #expect(result.conflictingQueens.contains(QueenPosition(row: 0, col: 0)))
        #expect(result.conflictingQueens.contains(QueenPosition(row: 0, col: 1)))
    }

    @Test("Same column conflict")
    func sameColumnConflict() {
        let queens: Set<QueenPosition> = [
            QueenPosition(row: 0, col: 0),
            QueenPosition(row: 1, col: 0),
        ]
        let gameState = GameState(n: 4, queens: queens)
        let result = NQueensValidator.validate(game: gameState)

        #expect(result.isSolved == false)
        #expect(result.conflictingQueens.count == 2)
    }

    @Test("Diagonal conflict (main diagonal)")
    func diagonalConflictMain() {
        let queens: Set<QueenPosition> = [
            QueenPosition(row: 0, col: 0),
            QueenPosition(row: 1, col: 1),
        ]
        let gameState = GameState(n: 4, queens: queens)
        let result = NQueensValidator.validate(game: gameState)

        #expect(result.isSolved == false)
        #expect(result.conflictingQueens.count == 2)
    }

    @Test("Diagonal conflict (anti-diagonal)")
    func diagonalConflictAnti() {
        let queens: Set<QueenPosition> = [
            QueenPosition(row: 0, col: 1),
            QueenPosition(row: 1, col: 0),
        ]
        let gameState = GameState(n: 4, queens: queens)
        let result = NQueensValidator.validate(game: gameState)

        #expect(result.isSolved == false)
        #expect(result.conflictingQueens.count == 2)
    }

    @Test("Multiple conflicts")
    func multipleConflicts() {
        let queens: Set<QueenPosition> = [
            QueenPosition(row: 0, col: 0),
            QueenPosition(row: 0, col: 1), // row conflict
            QueenPosition(row: 1, col: 0), // column conflict
            QueenPosition(row: 1, col: 1), // diagonal conflict
        ]
        let gameState = GameState(n: 4, queens: queens)
        let result = NQueensValidator.validate(game: gameState)

        #expect(result.isSolved == false)
        #expect(result.conflictingQueens.count == 4)
    }

    // MARK: - Edge Cases

    @Test("Not enough queens")
    func notEnoughQueens() {
        let queens: Set<QueenPosition> = [
            QueenPosition(row: 0, col: 0),
            QueenPosition(row: 1, col: 2),
        ]
        let gameState = GameState(n: 4, queens: queens)
        let result = NQueensValidator.validate(game: gameState)

        #expect(result.isSolved == false)
    }

    @Test("Too many queens")
    func tooManyQueens() {
        var queens: Set<QueenPosition> = []
        for i in 0..<5 {
            queens.insert(QueenPosition(row: i, col: i))
        }
        let gameState = GameState(n: 4, queens: queens)
        let result = NQueensValidator.validate(game: gameState)

        #expect(result.isSolved == false)
    }

    @Test("Empty board")
    func emptyBoard() {
        let gameState = GameState(n: 4, queens: [])
        let result = NQueensValidator.validate(game: gameState)

        #expect(result.isSolved == false)
        #expect(result.conflictingQueens.isEmpty)
    }

    @Test("N less than 4 ")
    func nLessThan4() {
        let queens: Set<QueenPosition> = []
        let gameState = GameState(n: 3, queens: queens)
        let result = NQueensValidator.validate(game: gameState)

        #expect(result.isSolved == false)
    }

    @Test("Complex diagonal conflict")
    func complexDiagonalConflict() {
        // Queens on diagonal r - c = constant
        let queens: Set<QueenPosition> = [
            QueenPosition(row: 2, col: 0),
            QueenPosition(row: 3, col: 1),
            QueenPosition(row: 4, col: 2),
        ]
        let gameState = GameState(n: 8, queens: queens)
        let result = NQueensValidator.validate(game: gameState)

        #expect(result.isSolved == false)
        #expect(result.conflictingQueens.count == 3)
    }
}
