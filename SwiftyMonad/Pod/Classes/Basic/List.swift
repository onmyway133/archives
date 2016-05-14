//
//  List.swift
//  Pods
//
//  Created by Khoa Pham on 9/26/15.
//
//

import Foundation

public struct List<X> {
    public let value: [X]

    public init(value v: [X]) {
        value = v
    }
}

extension List : Functor {
    public typealias A = X
    public typealias B = Any
    public typealias ContextA = List<A>
    public typealias ContextB = List<B>

    public func fmap(f: A -> B) -> ContextB {
        return ContextB(value: value.map(f))
    }

    public static func of(value: A) -> ContextA {
        return ContextA(value: [value])
    }
}

extension List : Monad {
    public static func unit(value: A) -> ContextA {
        return of(value)
    }

    public func flatMap(f: A -> ContextB) -> ContextB {
        // TODO
        return ContextB(value: [])
//        return ContextB(value: self.fmap(f))
    }

    public func use(context: ContextB) -> ContextB {
        return context
    }

    public func flatten() -> ContextA {
        // TODO
        return self
//        return ContextA(value: value.reduce([], combine: +))f
    }
}