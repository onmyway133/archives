//
//  Property.swift
//  Pods
//
//  Created by Khoa Pham on 9/27/15.
//
//

import Foundation

enum AVPlayerProperty : String {
    case CurrentItem = "currentItem"
    case Rate = "rate"
}

enum AVPlayerItemProperty : String {
    case Duration = "duration"
    case Status = "status"
    case PlaybackBufferEmpty = "playbackBufferEmpty"
    case PlaybackLikelyToKeepUp = "playbackLikelyToKeepUp"
}