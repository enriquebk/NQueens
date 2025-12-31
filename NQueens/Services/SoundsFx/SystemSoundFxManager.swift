//
//  SystemSoundFxManager.swift
//  NQueens
//
//  Created by Enrique Bermúdez on 20/12/25.
//

import AudioToolbox

final class SystemSoundFxManager: SoundFxManager {
    func playQueenTap() {
        AudioServicesPlaySystemSound(1104)
    }
}
