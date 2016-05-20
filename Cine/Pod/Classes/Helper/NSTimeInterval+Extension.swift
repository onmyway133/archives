//
//  NSTimeInterval+Extension.swift
//  Pods
//
//  Created by Khoa Pham on 9/29/15.
//
//

import Foundation
import CoreMedia

extension NSTimeInterval {
    func toCMTime() -> CMTime {
        return CMTime(seconds: self, preferredTimescale: 1000)
    }
}