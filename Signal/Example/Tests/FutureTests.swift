//
//  FutureTests.swift
//  Signal
//
//  Created by Khoa Pham on 1/2/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import XCTest
import Signal

class FutureTests: XCTestCase {
    func testStart() {
        let future = Future<Int>() { completion in
            completion(Event(value: 5))
        }

        future.start { event in
            if case let .Next(value) = event {
                XCTAssert(value == 5)
            } else {
                XCTAssert(false)
            }
        }
    }

    func testMap() {
        let _ = Future<String> { completion in
                completion(Event(value: "test"))
            }
            .map { value in
                value.characters.count
            }.start { event in
                if case let .Next(value) = event {
                    XCTAssert(value == 4)
                } else {
                    XCTAssert(false)
                }
            }
    }

    func testFlatmap() {
        let transform: String -> Future<Int> = { value in
            return Future<Int>() { completion in
                completion(Event(value: value.characters.count))
            }
        }

        let _ = Future<String> { completion in
            completion(Event(value: "test"))
            }
            .flatMap { value in
                transform(value)
            }.start { event in
                if case let .Next(value) = event {
                    XCTAssert(value == 4)
                } else {
                    XCTAssert(false)
                }
        }
    }
}
