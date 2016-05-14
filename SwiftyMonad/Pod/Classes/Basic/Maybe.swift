//
//  Maybe.swift
//  Pods
//
//  Created by Khoa Pham on 9/26/15.
//
//

import Foundation

public enum Maybe<X> {
    case Just(X)
    case Nothing
}

extension Maybe : Functor {
    public typealias A = X
    public typealias B = Any
    public typealias ContextA = Maybe<A>
    public typealias ContextB = Maybe<B>

    public func fmap(f: A -> B) -> ContextB {
        switch self {
        case let .Just(value):
            return ContextB.Just(f(value))
        case .Nothing:
            return .Nothing
        }
    }

    public static func of(value: A) -> ContextA {
        // TODO: Need to check for value
        return ContextA.Just(value)
    }
}

extension Maybe : Monad {
    public static func unit(value: A) -> ContextA {
        return of(value)
    }

    public func flatMap(f: A -> ContextB) -> ContextB {
        switch self {
        case let .Just(value):
            return f(value)
        case .Nothing:
            return .Nothing
        }
    }

    public func use(context: ContextB) -> ContextB {
        switch self {
        case .Just(_):
            return context
        case .Nothing:
            return .Nothing
        }
    }

    public func flatten() -> ContextA {
        switch self {
        case let .Just(value):
            if let v = value as? ContextA {
                return v
            } else {
                return self
            }
        case .Nothing:
            return self
        }
    }
}

extension Maybe : ApplicativeFunctor {
    public static func pure(value: A) -> ContextA {
        return of(value)
    }

    public func apply(context: ContextA) -> ContextB {
        if case let .Just(value) = self,
            let f = value as? (A->B),
            case let .Just(anotherValue) = context {
            return ContextB.Just(f(anotherValue))
        } else {
            return .Nothing
        }
    }
}