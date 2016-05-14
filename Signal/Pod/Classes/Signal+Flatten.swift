//
//  Signal+Flatten.swift
//  Pods
//
//  Created by Khoa Pham on 1/2/16.
//
//

import Foundation

public extension Signal {
    /**
     Forward inner signals Next event. In case of Failed, terminate and forward the first Failed
     */
    public func merge(signals: [Signal<T>]) -> Signal<T> {
        let final = Signal<T>()

        signals.forEach { signal in
            signal.subscribe { event in
                dispatch_sync(final.lockQueue) {
                    if case .Failed? = final.event {
                        return
                    }

                    final.update(event: event)
                }
            }
        }

        return final
    }

    // TODO:

    /**
    Forward inner signal Next event. The next signal is not started until the previous has completed. In case of Failed, terminate and forward the first Failed
    */
    public func concat(signals: [Signal<T>]) -> Signal<T> {
        fatalError("Not yet implemented")
    }

    /**
     Forward the latest inner Signal Next event. In case of Failed, terminate and forward the first Failed
     */
    public func lastest(signals: [Signal<T>]) -> Signal<T> {
        fatalError("Not yet implemented")
    }
}