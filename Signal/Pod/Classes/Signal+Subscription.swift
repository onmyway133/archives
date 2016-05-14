//
//  Signal+Subscription.swift
//  Pods
//
//  Created by Khoa Pham on 1/2/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

public extension Signal {
    // MARK: Subscription
    public func subscribe(f: Event<T> -> Void) -> Signal<T> {
        // Callback
        if let event = event {
            f(event)
        }

        callbacks.append(f)

        return self
    }

    public func subscribeNext(f: T -> Void) -> Signal<T> {
        return subscribe { event in
            if case let .Next(value) = event {
                f(value)
            }
        }
    }

    public func subscribeFailed(f: ErrorType -> Void) -> Signal<T> {
        return subscribe { event in
            if case let .Failed(error) = event {
                f(error)
            }
        }
    }
}