//
//  SwiftFrameworkTests_iOS.swift
//  SwiftFrameworkTests-iOS
//
//  Created by Khoa Pham on 04/04/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import XCTest
import Quick
import Nimble

class SwiftFrameworkTests_iOS_QuickSpec: QuickSpec {
  override func spec() {
    describe("basic") {
      expect(1+1).to(equal(2))
    }
  }
}
