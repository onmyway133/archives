//
//  Option.swift
//  Pods
//
//  Created by Khoa Pham on 9/27/15.
//
//

import Foundation

public struct Option {
    let enableExternalPlayback = true
    let enableBufferingWhenPaused = true
    let tickInterval: NSTimeInterval = 0.5

    public static func defaultOption() -> Option {
        return Option()
    }
}