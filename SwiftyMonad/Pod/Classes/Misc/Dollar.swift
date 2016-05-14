//
//  Dollar.swift
//  Pods
//
//  Created by Khoa Pham on 9/26/15.
//
//

import Foundation

// ($) :: (a -> b) -> a -> b
// f $ x = f x

// FIXME: Not as the same meaning as $
public func dollar<A, B>(a: A, f: A -> B) -> B {
    return f(a)
}