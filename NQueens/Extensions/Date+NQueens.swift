//
//  Date+NQueens.swift
//  NQueens
//
//  Created by Enrique Bermúdez on 20/12/25.
//

import Foundation

extension Date {
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: self)
    }

    func formattedTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: self)
    }
}
