//
//  Signal+Update.swift
//  Pods
//
//  Created by Khoa Pham on 1/2/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

public extension Signal {
    func update(event event: Event<T>) {
        dispatch_sync(lockQueue) {
            self.event = event
        }

        notify()
    }

    public func sendNext(value: T) {
        update(event: Event.Next(value: value))
    }

    public func sendFailed(error: ErrorType) {
        update(event: Event.Failed(error: error))
    }
}