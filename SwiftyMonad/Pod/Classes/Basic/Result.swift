//
//  Result.swift
//  Pods
//
//  Created by Khoa Pham on 9/26/15.
//
//

import Foundation

public enum Result<X> {
    case Value(X)
    case Error(NSError)
}

extension Result : Functor {
    public typealias A = X
    public typealias B = Any
    public typealias ContextA = Result<A>
    public typealias ContextB = Result<B>

    public func fmap(f: A -> B) -> ContextB {
        switch self {
        case let .Value(value):
            return ContextB.Value(f(value))
        case let .Error(error):
            return .Error(error)
        }
    }

    public static func of(value: A) -> ContextA {
        return ContextA.Value(value)
    }
}

extension Result : Monad {
    public static func unit(value: A) -> ContextA {
        return of(value)
    }

    public func flatMap(f: A -> ContextB) -> ContextB {
        switch self {
        case let .Value(value):
            return f(value)
        case let .Error(error):
            return .Error(error)
        }
    }

    public func use(context: ContextB) -> ContextB {
        switch self {
        case .Value(_):
            return context
        case let .Error(error):
            return .Error(error)
        }
    }

    public func flatten() -> ContextA {
        switch self {
        case let .Value(value):
            if let v = value as? ContextA {
                return v
            } else {
                return self
            }
        case .Error(_):
            return self
        }
    }
}

extension Result : ApplicativeFunctor {
    public static func pure(value: A) -> ContextA {
        return of(value)
    }

    public func apply(context: ContextA) -> ContextB {
        if case let .Value(value) = self,
            let f = value as? (A->B),
            case let .Value(anotherValue) = context {
                return ContextB.Value(f(anotherValue))
        } else {
            // TODO: Find a better way to return
            switch self {
            case let .Value(value):
                return ContextB.Value(value)
            case let .Error(error):
                return .Error(error)
            }
        }
    }
}