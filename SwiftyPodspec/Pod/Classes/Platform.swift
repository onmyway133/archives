//
//  Platform.swift
//  Pods
//
//  Created by Khoa Pham on 1/16/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

public struct Platform {
    public enum Type {
        case iOS
        case OSX
        case tvOS
        case watchOS
    }

    let type: Type
    let version: Version

    public init(type: Type, version: Version) {
        self.type = type
        self.version = version
    }
}