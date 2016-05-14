//
//  Signal+Failed.swift
//  Pods
//
//  Created by Khoa Pham on 1/2/16.
//
//

import Foundation

public extension Signal {
    /**
     Transform Failed error into a new error
     */
    public func mapFailed(f: ErrorType -> ErrorType) -> Signal {
        let signal = Signal<T>()

        subscribe { event in
            signal.update(event: event.mapFailed(f))
        }

        return signal
    }
}