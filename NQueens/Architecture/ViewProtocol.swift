//
//  ViewProtocol.swift
//  NQueens
//
//  Created by Enrique Bermúdez on 29/12/25.
//

import SwiftUI

/// Protocol that defines the contract for Views that use ViewModels
protocol ViewProtocol: View {
    associatedtype ViewModelType: ViewModel

    var viewModel: ViewModelType { get }
}

extension ViewProtocol {
    var state: ViewModelType.State {
        viewModel.state
    }

    func handle(_ event: ViewModelType.Event) {
        viewModel.handle(event)
    }
}
