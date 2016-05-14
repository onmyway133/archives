//
//  Signal.swift
//  Pods
//
//  Created by Khoa Pham on 12/30/15.
//  Copyright © 2015 Fantageek. All rights reserved.
//

import Foundation

public final class Signal<T> {
    var event: Event<T>?
    var callbacks: [Event<T> -> Void] = []
    let lockQueue = dispatch_queue_create("lock_queue", DISPATCH_QUEUE_SERIAL)


    // MARK: Initialization
    public init(event: Event<T>) {
        self.event = event
    }

    public init(value: T) {
        self.event = Event.Next(value: value)
    }

    public init() {

    }

    func notify() {
        guard let event = event else {
            return
        }

        callbacks.forEach { callback in
            callback(event)
        }
    }
}