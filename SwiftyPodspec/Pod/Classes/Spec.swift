//
//  Spec.swift
//  Pods
//
//  Created by Khoa Pham on 1/16/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation
import Configurable

public class Spec {
    public var name: String?
    public var version: Version?
    public var license: License?
    public var homepage: NSURL?
    public var screenshots: [NSURL]?
    public var author: [Author]?
    public var summary: String?
    public var socialMediaURL: NSURL?
    public var sourceFiles: [String]?
    public var frameworks: [String]?
    public var subspecs: [Spec]?
    public var platform: [Platform]?
    public var source: Source?
    public var dependencies: [Dependency]?

    public init() {

    }
}

extension Spec: Configurable {}