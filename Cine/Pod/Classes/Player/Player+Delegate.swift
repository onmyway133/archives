//
//  Player+Delegate.swift
//  Pods
//
//  Created by Khoa Pham on 9/29/15.
//
//

import Foundation

extension Player {
    func notifyDidChangeCurrentItem() {
        notify { delegate in
            delegate.playerDidChangeCurrentItem(self)
        }
    }

    func notifyDidChangePlaybackState(playbackState: PlaybackState) {
        notify { delegate in
            delegate.player(self, didChangePlaybackState: playbackState)
        }
    }


    func notifyDidChangeStatus(status: Status) {
        notify { delegate in
            delegate.player(self, didChangeStatus: status)
        }
    }

    func notifyDidLoadDuration() {
        notify { delegate in
            delegate.playerDidLoadDuration(self)
        }
    }

    func notifyDidChangeLoadState(loadState: LoadState) {
        notify { delegate in
            delegate.player(self, didChangeLoadState: loadState)
        }
    }

    func notifyDidFinishWithResult(result: Result) {
        notify { delegate in
            delegate.player(self, didFinishWithResult: result)
        }
    }

    func notifyDidTick() {
        notify { delegate in
            delegate.playerDidTick(self)
        }
    }

    func notifyDidBeginSeeking() {
        notify { delegate in
            delegate.playerDidBeginSeeking(self)
        }
    }

    func notifyDidEndSeeking() {
        notify { delegate in
            delegate.playerDidEndSeeking(self)
        }
    }
}


extension Player {
    func notify(body: (delegate: PlayerDelegate) -> Void) {
        dispatch_async(Dispatch.mainQueue()) {
            self.delegates.forEach({ delegate in
                if let delegate = delegate as? PlayerDelegate {
                    body(delegate: delegate)
                }
            })
        }
    }
}
