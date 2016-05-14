//
//  Signal+Debounce.swift
//  Pods
//
//  Created by Khoa Pham on 1/2/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation
import Throttle

public extension Signal {
    /**
     Throttle values sent by the receiver, so that at least `interval`
     seconds pass between each, then forwards them on the given scheduler.

     If multiple values are received before the interval has elapsed, the
     latest value is the one that will be passed on.
     */
    public func debounce(timeInterval: NSTimeInterval) -> Signal<T> {
        let signal = Signal<T>()

        // FIXME: Throttle dispatches on the queue passed in its constructor
        let throttle = Throttle(interval: timeInterval)
        subscribe { event in
            throttle.actionBlock = {
                signal.update(event: event)
            }

            throttle.fire()
        }

        return signal
    }
}