//
//  Player.swift
//  Pods
//
//  Created by Khoa Pham on 9/27/15.
//
//

import Foundation
import AVFoundation
import KVOController

// Subclass NSObject to make repondsToSelector work
public class Player : NSObject {
    public let option: Option
    public var player: AVPlayer?
    public let layer: AVPlayerLayer

    var delegates = NSHashTable.weakObjectsHashTable()
    // TODO: Newer Xcode can fix this. NSHashTable is not generic
//    public let delegates = [WeakContainer<PlayerDelegate>]()

    var playerKVOController: FBKVOController?
    var playerItemKVOController: FBKVOController?
    var timeObservers = [AnyObject]()
    let queue = dispatch_queue_create("player_queue", DISPATCH_QUEUE_SERIAL)

    public init(option anOption: Option, layer aLayer: AVPlayerLayer) {
        option = anOption
        layer = aLayer
    }

    deinit {
        terminate()
    }
}

extension Player {
    public func addDelegate(delegate: PlayerDelegate) {
        delegates.addObject(delegate)
    }
}