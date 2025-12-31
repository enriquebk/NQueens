//
//  ViewModelProtocol.swift
//  NQueens
//
//  Created by Enrique Bermúdez on 29/12/25.
//

import Combine
import Foundation

/// Protocol that defines the contract for all ViewModels in the MVVM-C architecture
protocol ViewModel: ObservableObject {
    associatedtype State
    associatedtype Event
    associatedtype Effect

    typealias ViewChange = (State, [Effect])

    var state: State { get set }

    /// Process a side effect
    func process(_ effect: Effect)

    /// Pure, deterministic reducer that maps an Event + current State into a new State and Effects.
    /// - Parameters:
    ///   - event: The incoming event to handle.
    ///   - currentState: The state before handling the event.
    /// - Returns: A tuple containing the next state and the list of side effects to be processed ..
    static func reduce(_ event: Event, currentState: State) -> ViewChange
}

extension ViewModel {
    /// Handles an Event by running the static reducer, updating the state, and then processing the returned effects in order.
    func handle(_ event: Event) {
        let (newState, effects) = Self.reduce(event, currentState: state)
        state = newState

        effects.forEach { process($0) }
    }
}
