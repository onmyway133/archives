//
//  CMTime+Extension.swift
//  Pods
//
//  Created by Khoa Pham on 9/29/15.
//
//

import Foundation
import CoreMedia

extension CMTime {
    func toTimeInterval() -> NSTimeInterval {
        return isValid() ? NSTimeInterval(CMTimeGetSeconds(self)) : 0
    }

    func isValid() -> Bool {
        return !CMTIME_IS_INDEFINITE(self)
            && !CMTIME_IS_INVALID(self)
            && CMTIME_IS_VALID(self)
    }

    func isInRange(range: CMTimeRange) -> Bool {
        return CMTimeRangeContainsTime(range, self)
    }
}
