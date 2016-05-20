//
//  Player+AVPlayerItem.swift
//  Pods
//
//  Created by Khoa Pham on 9/27/15.
//
//

import Foundation
import AVFoundation
import KVOController
import CoreMedia

extension Player {
    func observePlayerItem(playerItem: AVPlayerItem) {
        playerItemKVOController = FBKVOController(observer: self)

        let options: NSKeyValueObservingOptions = [.Initial, .New]

        playerItemKVOController?.observe(playerItem,
            keyPath: AVPlayerItemProperty.Status.rawValue,
            options: options,
            action: Selector("playerItemDidChangeStatus:object:"))

        playerItemKVOController?.observe(playerItem,
            keyPath: AVPlayerItemProperty.Duration.rawValue,
            options: options,
            action: Selector("playerItemDidLoadDuration:object:"))

        playerItemKVOController?.observe(playerItem,
            keyPath: AVPlayerItemProperty.PlaybackBufferEmpty.rawValue,
            options: options,
            action: Selector("playerItemDidChangeLoadState:object:"))

        playerItemKVOController?.observe(playerItem,
            keyPath: AVPlayerItemProperty.PlaybackLikelyToKeepUp.rawValue,
            options: options,
            action: Selector("playerItemDidChangeLoadState:object:"))

        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: Selector("playerItemDidPlayToEnd:"),
            name: AVPlayerItemDidPlayToEndTimeNotification,
            object: playerItem)

        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: Selector("playerItemFailedToPlayToEnd:"),
            name: AVPlayerItemFailedToPlayToEndTimeNotification,
            object: playerItem)

        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: Selector("playerItemPlaybackStalled:"),
            name: AVPlayerItemPlaybackStalledNotification,
            object: playerItem)
    }

    func unobserveCurrentItem() {
        playerItemKVOController = nil

        // TODO: what if currentItem is nil, how does KVO removal works?
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: nil,
            object: player?.currentItem)
    }
}

extension Player {
    func playerItemDidChangeStatus(change: [String:AnyObject]?, object: AnyObject?) {
        guard let change = change?[NSKeyValueChangeNewKey],
            number = change as? NSNumber,
            status = Status(rawValue: number.integerValue)
            else {
                return
            }

        notifyDidChangeStatus(status)
    }

    func playerItemDidLoadDuration(change: [String:AnyObject]?, object: AnyObject?) {
        var duration = kCMTimeIndefinite

        guard let change = change?[NSKeyValueChangeNewKey],
            value = change as? NSValue
            else {
                return
            }

        value.getValue(&duration)
        if !duration.isValid() {
            return
        }

        notifyDidLoadDuration()
    }

    func playerItemDidChangeLoadState(change: [String:AnyObject]?, object: AnyObject?) {
        guard let playerItem = object as? AVPlayerItem
            else {
                return
            }

        let loadState: LoadState = {
            if playerItem.playbackLikelyToKeepUp {
                return .PlaythroughOK
            }

            if playerItem.playbackBufferEmpty {
                return .Stalled
            } else {
                return .Playable
            }
        }()

        notifyDidChangeLoadState(loadState)
    }

    func playerItemDidPlayToEnd(notification: NSNotification) {
        notifyDidFinishWithResult(.Success)
    }

    func playerItemFailedToPlayToEnd(notification: NSNotification) {
        let error = notification.userInfo?[AVPlayerItemFailedToPlayToEndTimeErrorKey] as? NSError
        notifyDidFinishWithResult(.Failure(error))
    }

    func playerItemPlaybackStalled(notification: NSNotification) {
        notifyDidChangeLoadState(.Stalled)
    }
}
