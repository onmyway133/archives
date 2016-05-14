//
//  Function.swift
//  Pods
//
//  Created by Khoa Pham on 9/27/15.
//
//

import Foundation

public struct Function<X, Y> {
    // TODO: Should encapsulate
    public let value: (X -> Y)

    public init(value v: X -> Y) {
        value = v
    }
}

extension Function : Functor {
    public typealias A = Y
    public typealias B = Any
    public typealias ContextA = Function<X, A>
    public typealias ContextB = Function<X, B>

    public func fmap(f: A -> B) -> ContextB {
        return ContextB(value: compose(f, value))
    }

    public static func of(value: A) -> ContextA {
        return ContextA(value: {
            x in
            value
        })
    }
}