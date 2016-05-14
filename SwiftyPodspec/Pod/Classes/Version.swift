//
//  Version.swift
//  Pods
//
//  Created by Khoa Pham on 1/16/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

public struct Version {
    let major: Int
    let minor: Int
    let patch: Int

    public init(major: Int, minor: Int = 0, patch: Int = 0) {
        self.major = major
        self.minor = minor
        self.patch = patch
    }
}