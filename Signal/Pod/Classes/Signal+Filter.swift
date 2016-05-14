//
//  Signal+Filter.swift
//  Pods
//
//  Created by Khoa Pham on 1/2/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

public extension Signal {
    /**
     Filter Next values
     */
    public func filter(f: T -> Bool) -> Signal<T> {
        let signal = Signal<T>()

        subscribe { event in
            event.filter(f)(signal.update)
        }

        return signal
    }
}