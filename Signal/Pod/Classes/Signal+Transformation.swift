//
//  Signal+Transformation.swift
//  Pods
//
//  Created by Khoa Pham on 1/2/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

public extension Signal {
    // MARK: Sync transformation
    public func map<U>(f: T -> U) -> Signal<U> {
        let signal = Signal<U>()

        subscribe { event in
            signal.update(event: event.map(f))
        }

        return signal
    }

    public func flatMap<U>(f: T -> Event<U>) -> Signal<U> {
        let signal = Signal<U>()

        subscribe { event in
            signal.update(event: event.flatMap(f))
        }

        return signal
    }

    // MARK: Async transformation
    public func flatMap<U>(f: (T, Event<U> -> Void) -> Void) -> Signal<U> {
        let signal = Signal<U>()

        subscribe { event in
            event.flatMap(f)(signal.update)
        }
        
        return signal
    }
}