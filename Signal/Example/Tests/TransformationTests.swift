//
//  TransformationTests.swift
//  Signal
//
//  Created by Khoa Pham on 1/2/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import XCTest
import Signal

class TransformationTests: XCTestCase {
    func testMap() {
        let signal = Signal<String>()

        signal.map { value in
                return value.characters.count
            }.subscribe { event in
                if case let .Next(value) = event {
                    XCTAssert(value == 4)
                } else {
                    XCTAssert(false)
                }
        }

        signal.sendNext("test")
    }
}
