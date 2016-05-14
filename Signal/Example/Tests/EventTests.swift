//
//  EventTests.swift
//  Signal
//
//  Created by Khoa Pham on 1/2/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import XCTest
@testable import Signal

class EventTests: XCTestCase {
    func testNext() {
        let event = Event.Next(value: 5)
        if case let .Next(value) = event {
            XCTAssert(value == 5)
        } else {
            XCTAssert(false)
        }
    }

    func testFailed() {
        let error = NSError(domain: "failed", code: 0, userInfo: nil)

        let event = Event<Any>.Failed(error: error)
        if case let .Failed(error) = event {
            let e = error as NSError
            XCTAssert(e.domain == "failed")
        } else {
            XCTAssert(false)
        }
    }
}
