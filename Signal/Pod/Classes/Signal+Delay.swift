//
//  Signal+Delay.swift
//  Pods
//
//  Created by Khoa Pham on 1/2/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

public extension Signal {
    /**
     Delays `Next` events by the given interval, forwarding them on the given scheduler.
     */
    public func delay(timeInternal: NSTimeInterval, queue: dispatch_queue_t = dispatch_get_main_queue()) -> Signal<T> {
        let signal = Signal<T>()

        subscribe { event in
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(timeInternal * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, queue) {
                signal.update(event: event)
            }
        }

        return signal
    }
}