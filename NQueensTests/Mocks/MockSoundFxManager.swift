//
//  MockSoundFxManager.swift
//  NQueens
//
//  Created by Enrique Bermúdez on 26/12/25.
//

import Foundation
@testable import NQueens

// periphery: ignore
final class MockSoundFxManager: SoundFxManager {
    var playQueenTapCallCount = 0

    func playQueenTap() {
        playQueenTapCallCount += 1
    }
}
