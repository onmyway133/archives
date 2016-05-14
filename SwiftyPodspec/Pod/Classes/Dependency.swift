//
//  Dependency.swift
//  Pods
//
//  Created by Khoa Pham on 1/16/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

public struct Dependency {
    let name: String
    let version: Version?

    public init(name: String, version: Version? = nil) {
        self.name = name
        self.version = version
    }
}