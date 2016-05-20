//
//  State.swift
//  Pods
//
//  Created by Khoa Pham on 9/27/15.
//
//

import Foundation
import AVFoundation

public enum Status : Int {
    case Unknown, ReadyToPlay, Failed
}

public enum PlaybackState {
    case Playing, Paused
}

public enum LoadState {
    case Unknown, Playable, PlaythroughOK, Stalled
}
