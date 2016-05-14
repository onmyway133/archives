//
//  IO.swift
//  Pods
//
//  Created by Khoa Pham on 9/26/15.
//
//

import Foundation

public struct IO<X> {
    // TODO: Should encapsulate
    public let value: (Any -> X)

    public init(value v: Any -> X) {
        value = v
    }
}

extension IO : Functor {
    public typealias A = X
    public typealias B = Any
    public typealias ContextA = IO<A>
    public typealias ContextB = IO<B>

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

extension IO : Monad {
    public static func unit(value: A) -> ContextA {
        return of(value)
    }

    public func flatMap(f: A -> ContextB) -> ContextB {
        // TODO:
        return ContextB(value: {
            $0
        })
    }

    public func use(context: ContextB) -> ContextB {
        return context
    }

    public func flatten() -> ContextA {
        // TODO:
        return self
    }
}