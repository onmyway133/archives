//
//  Player+Control.swift
//  Pods
//
//  Created by Khoa Pham on 9/29/15.
//
//

import Foundation
import AVFoundation

public extension Player {
    func play(url: NSURL, autoplay: Bool = true) {
        let playerItem = AVPlayerItem(URL: url)
        setupPlayerWithPlayerItem(playerItem)

        if (autoplay) {
            resume()
        }
    }

    func pause() {
        player?.pause()
    }

    func resume() {
        player?.play()
    }

    func stop() {

    }

    func terminate() {
        pause()

        unobserveCurrentItem()
        unobservePlayer()
        
        player = nil
    }
}

public extension Player {
    func seekToStart() {
        currentPlaybackTime = 0
    }

    func rewind() {

    }

    func fastForward() {

    }

    func setVolume(volume: Float) {
        player?.volume = volume
    }
}