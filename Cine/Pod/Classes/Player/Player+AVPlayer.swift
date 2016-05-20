//
//  Player+AVPlayer.swift
//  Pods
//
//  Created by Khoa Pham on 9/27/15.
//
//

import Foundation
import AVFoundation
import KVOController

extension Player {
    func setupPlayerWithPlayerItem(playerItem: AVPlayerItem) {
        if player == nil {
            let player = AVPlayer(playerItem: playerItem)
            applyOptionToPlayer(player)
            observePlayer(player)

            layer.player = player
            self.player = player
        } else {
            removeTimeObservers()
            unobserveCurrentItem()
            player?.replaceCurrentItemWithPlayerItem(playerItem)
        }

        applyOptionToPlayerItem(playerItem)
        observePlayerItem(playerItem)
        setupTimeObservers()
    }
}

extension Player {
    func observePlayer(player: AVPlayer) {
        playerKVOController = FBKVOController(observer: self)

        let options: NSKeyValueObservingOptions = [.Initial, .New]

        playerKVOController?.observe(player,
            keyPath: AVPlayerProperty.CurrentItem.rawValue,
            options: options,
            action: Selector("playerDidChangeCurrentItem:object:"))

        playerKVOController?.observe(player,
            keyPath: AVPlayerProperty.Rate.rawValue,
            options: options,
            action: Selector("playerDidChangePlaybackState:object:"))
    }

    func unobservePlayer() {
        playerKVOController = nil
    }
}

extension Player {
    func playerDidChangeCurrentItem(change: [String:AnyObject]?, object: AnyObject?) {
        guard let playerItem = change?[NSKeyValueChangeNewKey] where playerItem is AVPlayerItem,
            let player = player
            else {
                return
        }

        // Reassign the layer
        layer.player = player

        notifyDidChangeCurrentItem()
    }

    func playerDidChangePlaybackState(change: [String:AnyObject]?, object: AnyObject?) {
        notifyDidChangePlaybackState(self.playbackState)
    }
}

extension Player {
    private func applyOptionToPlayer(player: AVPlayer) {
        player.actionAtItemEnd = .Pause
        player.allowsExternalPlayback = option.enableExternalPlayback
    }

    private func applyOptionToPlayerItem(playerItem: AVPlayerItem) {
        if #available(iOS 9.0, *) {
            playerItem.canUseNetworkResourcesForLiveStreamingWhilePaused = option.enableBufferingWhenPaused
        }
    }
}