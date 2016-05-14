//
//  Either.swift
//  Pods
//
//  Created by Khoa Pham on 9/26/15.
//
//

import Foundation

// Only affect Left
public enum Either<X, Y> {
    case Left(X)
    case Right(Y)
}

extension Either : Functor {
    public typealias A = X
    public typealias B = Any
    public typealias ContextA = Either<A, Y>
    public typealias ContextB = Either<B, Y>

    public func fmap(f: A -> B) -> ContextB {
        switch self {
        case let .Left(value):
            return ContextB.Left(f(value))
        case let .Right(value):
            return ContextB.Right(value)
        }
    }

    public static func of(value: A) -> ContextA {
        return ContextA.Left(value)
    }
}

extension Either : Monad {
    public static func unit(value: A) -> ContextA {
        return of(value)
    }

    public func flatMap(f: A -> ContextB) -> ContextB {
        switch self {
        case let .Left(value):
            return f(value)
        case let .Right(value):
            return .Right(value)
        }
    }

    public func use(context: ContextB) -> ContextB {
        switch self {
        case .Left(_):
            return context
        case let .Right(value):
            return .Right(value)
        }
    }

    public func flatten() -> ContextA {
        switch self {
        case let .Left(value):
            if let v = value as? ContextA {
                return v
            } else {
                return self
            }
        case .Right(_):
            return self
        }
    }

}