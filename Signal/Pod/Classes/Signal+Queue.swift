//
//  Signal+Queue.swift
//  Pods
//
//  Created by Khoa Pham on 1/2/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

public extension Signal {
    /**
     Dispatch event on a specified queue
     */
    public func on(queue: dispatch_queue_t = dispatch_get_main_queue()) -> Signal<T> {
        let signal = Signal<T>()

        subscribe { event in
            dispatch_async(queue) {
                signal.update(event: event)
            }
        }

        return signal
    }
}