//
//  LeftPadTests.swift
//  LeftPad
//
//  Created by Khoa Pham on 25/03/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import XCTest
import LeftPad

class LeftPadTests: XCTestCase {
  
    func test() {
      
      XCTAssert("foo".leftPad(5) == "  foo")
      XCTAssert("foobar".leftPad(6) == "foobar")
      XCTAssert("hello".leftPad(7, character: "☘") == "☘☘hello")
    }
}
