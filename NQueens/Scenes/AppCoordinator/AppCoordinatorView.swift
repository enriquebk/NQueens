//
//  Coordinator 2.swift
//  NQueens
//
//  Created by Enrique Bermúdez on 29/12/25.
//

import SwiftUI

struct AppCoordinatorView: Coordinator, View {
    private let store: BestTimesStore
    @StateObject var navigationStack = NavigationStackController<Route>()

    enum Route: Hashable {
        case startView
        case game(n: Int)
        case bestTimes
        case win(seconds: Int, n: Int)
    }

    init(store: BestTimesStore = UserDefaultsBestTimesStore()) {
        self.store = store
    }

    @ViewBuilder
    func build(route: Route) -> some View {
        switch route {
        case .startView:
            StartView(
                onStart: startGame,
                onBestTimes: showBestTimes
            )
        case let .game(n):
            GameView(
                viewModel: GameViewModel(
                    n: n,
                    bestTimesStore: store,
                    onWin: showWinGame
                )
            )
        case .bestTimes:
            BestTimesView(viewModel: BestTimesViewModel(store: store))
        case let .win(seconds, n):
            WinView(seconds: seconds, n: n, onBackToStart: goBackToStart)
        }
    }

    var body: some View {
        NavigationStack(path: $navigationStack.path) {
            build(route: .startView)
                .navigationDestination(for: Route.self) { route in
                    build(route: route)
                }
        }
        .tint(DesignSystem.Colors.accentDark)
    }

    // MARK: - Navigation

    private func startGame(n: Int) { push(.game(n: n)) }

    private func showBestTimes() { push(.bestTimes) }

    private func showWinGame(seconds: Int, n: Int) { push(.win(seconds: seconds, n: n)) }

    private func goBackToStart() { popToRoot() }
}
