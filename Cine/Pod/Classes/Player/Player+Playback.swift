//
//  Player+Playback.swift
//  Pods
//
//  Created by Khoa Pham on 9/27/15.
//
//

import Foundation
import AVFoundation

public extension Player {
    var currentPlaybackTime: NSTimeInterval {
        get {
            return playerItemPlaybackTime
        }

        set(newValue) {
            setCurrentPlaybackTime(newValue, autoplay: false)
        }
    }

    var duration: NSTimeInterval {
        return playerItemDuration
    }

    var playableDuration: NSTimeInterval {
        return playerItemPlayableDuration
    }
}

private extension Player {
    var playerItemPlaybackTime: NSTimeInterval {
        return player?.currentItem?.currentTime().toTimeInterval() ?? 0
    }

    var playerItemDuration: NSTimeInterval {
        guard let playerItem = player?.currentItem
            else {
                return 0
            }

        if (playerItem.duration.isValid()) {
            return playerItem.duration.toTimeInterval()
        } else {
            return 0
        }
    }

    var playerItemPlayableDuration: NSTimeInterval {
        guard let playerItem = player?.currentItem
            else {
                return 0
        }

        let loadTimeRanges = playerItem.loadedTimeRanges

        for value in loadTimeRanges {
            let range = value.CMTimeRangeValue
            if playerItem.currentTime().isInRange(range) {
                return CMTimeRangeGetEnd(range).toTimeInterval()
            }
        }

        return 0
    }
}

public extension Player {
    func setCurrentPlaybackTime(playbackTime: NSTimeInterval, autoplay: Bool) {
        notifyDidBeginSeeking()

        player?.seekToTime(playbackTime.toCMTime(),
            toleranceBefore: kCMTimeZero,
            toleranceAfter: kCMTimeZero,
            completionHandler: { [weak self] finished in
                if finished {
                    if autoplay {
                        self?.resume()
                    } else {
                        self?.pause()
                    }
                }

            self?.notifyDidEndSeeking()

            })
    }
}