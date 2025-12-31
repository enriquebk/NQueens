//
//  Coordinator.swift
//  NQueens
//
//  Created by Enrique Bermúdez on 30/12/25.
//

import SwiftUI

@MainActor
final class NavigationStackController<Route: Hashable>: ObservableObject {
    @Published var path = NavigationPath()

    /// Push a new route onto the navigation stack
    func push(_ route: Route) { path.append(route) }

    // periphery: ignore
    /// Pop the last route from the navigation stack
    func pop() { if !path.isEmpty { path.removeLast() } }

    /// Pop all routes and return to root
    func popToRoot() { path.removeLast(path.count) }
}

protocol Coordinator {
    associatedtype AppRoute: Hashable

    var navigationStack: NavigationStackController<AppRoute> { get }
}

extension Coordinator {
    @MainActor
    func push(_ route: AppRoute) { navigationStack.push(route) }

    // periphery: ignore
    @MainActor
    func pop() { if !navigationStack.path.isEmpty { navigationStack.pop() } }

    @MainActor
    func popToRoot() { navigationStack.popToRoot() }
}
