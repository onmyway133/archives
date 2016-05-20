//
//  Player+TimeObserver.swift
//  Pods
//
//  Created by Khoa Pham on 9/29/15.
//
//

import Foundation
import AVFoundation
import CoreMedia

extension Player {
    func setupTimeObservers() {
        observeTick()
    }
}

extension Player {
    @warn_unused_result
    func addPeriodTimeObserver(interval: NSTimeInterval, body: (timeInterval: NSTimeInterval) -> Void) -> AnyObject? {
        let observer = player?.addPeriodicTimeObserverForInterval(interval.toCMTime(), queue: Dispatch.mainQueue(), usingBlock: { time -> Void in
            body(timeInterval: time.toTimeInterval())
        })

        addTimeObserver(observer)
        return observer
    }

    @warn_unused_result
    func addBoundaryTimeObserver(interval: NSTimeInterval, body: ()->Void) -> AnyObject? {
        let observer = player?.addBoundaryTimeObserverForTimes([],
            queue: Dispatch.mainQueue(),
            usingBlock: {
                body()
        })

        addTimeObserver(observer)
        return observer
    }
}

extension Player {
    func addTimeObserver(observer: AnyObject?) {
        if let observer = observer {
            Dispatch.async(queue) { [weak self] in
                self?.timeObservers.append(observer)
            }
        }
    }

    func removeTimeObserver(observer: AnyObject) {
        Dispatch.async(queue) { [weak self] in
            self?.player?.removeTimeObserver(observer)
            // TODO: Should also remove observer from timeObservers
        }
    }

    func removeTimeObservers() {
        Dispatch.async(queue) { [weak self] in
            self?.timeObservers.forEach({ observer in
                player?.removeTimeObserver(observer)
            })

            self?.timeObservers.removeAll()
        }
    }
}

extension Player {
    func observeTick() {
        let _ = addPeriodTimeObserver(option.tickInterval) { [weak self] timeInterval in
            self?.notifyDidTick()
        }
    }
}