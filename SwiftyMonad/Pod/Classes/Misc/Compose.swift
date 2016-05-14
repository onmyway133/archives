//
//  Compose.swift
//  Pods
//
//  Created by Khoa Pham on 9/26/15.
//
//

import Foundation

// associativity
// compose(f, compose(g, h)) == compose(compose(f, g), h)

public func compose<A, B, C>(f: B -> C, _ g: A -> B) -> (A -> C) {
    return { x in
        f(g(x))
    }
}

// (.) :: (b -> c) -> (a -> b) -> a -> c
// (f . g) x = f (g x)
infix operator >>> { associativity left }
public func >>> <A, B, C>(f: B -> C, g: A -> B) -> (A -> C) {
    return compose(f, g)
}