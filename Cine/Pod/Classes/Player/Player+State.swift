//
//  Player+State.swift
//  Pods
//
//  Created by Khoa Pham on 9/29/15.
//
//

import Foundation

public extension Player {
    var playbackState: PlaybackState {
        guard let player = player
            else {
                return .Paused
            }

        return (player.rate == 1.0) ? .Playing : .Paused
    }

    var isPlaying: Bool {
        return playbackState == .Playing
    }
}

public extension Player {
    var status: Status {
        guard let playerItem = player?.currentItem
            else {
                return .Unknown
            }

        return Status(rawValue: playerItem.status.rawValue) ?? .Unknown
    }

    var isReadyToPlay: Bool {
        return status == .ReadyToPlay
    }
}