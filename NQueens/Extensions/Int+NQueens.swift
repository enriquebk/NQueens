//
//  Int+NQueens.swift
//  NQueens
//
//  Created by Enrique Bermúdez on 22/12/25.
//

extension Int {
    func formattedTimeMMSS() -> String {
        let minutes = self / 60
        let seconds = self % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
