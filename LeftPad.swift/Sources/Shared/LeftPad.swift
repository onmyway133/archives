//
//  LeftPad.swift
//  LeftPad
//
//  Created by Khoa Pham on 25/03/16.
//  Copyright © 2016 Fantageek. All rights reserved.
//

import Foundation

public extension String {
  public func leftPad(padding: Int, character: Character = " ") -> String {
    return String(count: (padding - self.characters.count), repeatedValue: character) + self
  }
}