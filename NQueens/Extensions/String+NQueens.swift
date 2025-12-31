//
//  String+NQueens.swift
//  NQueens
//
//  Created by Enrique Bermúdez on 26/12/25.
//

extension String {
    static func accessibilityLabelFor(n: Int, row: Int, column: Int) -> String {
        let rowLabel = "\(n - row)"
        let columnLabel = columnToLetters(column)
        return rowLabel + columnLabel
    }

    private static func columnToLetters(_ column: Int) -> String {
        var result = ""
        var value = column

        while value >= 0 {
            let remainder = value % 26
            let scalar = UnicodeScalar(97 + remainder)! // 97 = "a"
            result = String(scalar) + result
            value = value / 26 - 1
        }

        return result
    }
}
