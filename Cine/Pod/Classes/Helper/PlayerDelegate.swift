//
//  PlayerDelegate.swift
//  Pods
//
//  Created by Khoa Pham on 9/27/15.
//
//

import Foundation

public protocol PlayerDelegate : class {
    func player(player: Player, didChangeStatus status: Status)
    func player(player: Player, didChangePlaybackState state: PlaybackState)
    func player(player: Player, didChangeLoadState state: LoadState)

    func player(player: Player, didFinishWithResult: Result)

    func playerDidChangeCurrentItem(player: Player)
    func playerDidLoadDuration(player: Player)
    func playerDidTick(player: Player)

    func playerDidBeginSeeking(player: Player)
    func playerDidEndSeeking(player: Player)
}

public extension PlayerDelegate {
    func player(player: Player, didChangeStatus status: Status) {}
    func player(player: Player, didChangePlaybackState state: PlaybackState) {}
    func player(player: Player, didChangeLoadState state: LoadState) {}

    func player(player: Player, didFinishWithResult: Result) {}

    func playerDidChangeCurrentItem(player: Player) {}
    func playerDidLoadDuration(player: Player) {}
    func playerDidTick(player: Player) {}

    func playerDidBeginSeeking(player: Player) {}
    func playerDidEndSeeking(player: Player) {}
}