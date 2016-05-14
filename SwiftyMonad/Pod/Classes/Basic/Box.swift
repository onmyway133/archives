//
//  Box.swift
//  Pods
//
//  Created by Khoa Pham on 9/26/15.
//
//

import Foundation

public struct Box<X> {
    // TODO: Should encapsulate
    public let value: X

    public init(value v: X) {
        value = v
    }
}

extension Box : Functor {
    public typealias A = X
    public typealias B = Any
    public typealias ContextA = Box<A>
    public typealias ContextB = Box<B>

    public func fmap(f: A -> B) -> ContextB {
        return ContextB(value: f(value))
    }

    public static func of(value: A) -> ContextA {
        return ContextA(value: value)
    }
}

extension Box : Monad {
    public static func unit(value: A) -> ContextA {
        return of(value)
    }

    public func flatMap(f: A -> ContextB) -> ContextB {
        return f(value)
    }

    public func use(context: ContextB) -> ContextB {
        return context
    }

    public func flatten() -> ContextA {
        if let v = value as? ContextA {
            return v
        }

        return self
    }
}

extension Box : ApplicativeFunctor {
    public static func pure(value: A) -> ContextA {
        return of(value)
    }

    public func apply(context: ContextA) -> ContextB {
        if let f = value as? (A -> B) {
            return ContextB(value: f(value))
        } else {
            return ContextB(value: value)
        }
    }
}