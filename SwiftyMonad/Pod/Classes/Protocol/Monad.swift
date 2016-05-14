//
//  Monad.swift
//  Pods
//
//  Created by Khoa Pham on 9/26/15.
//
//

import Foundation

// class Monad m where
public protocol Monad : Functor {
    // return :: a -> m a
    // of, point, unit, return, pure
    static func unit(value: A) -> ContextA

    // (>>=) :: m a -> (a -> m b) -> m b
    // bind, flatMap, chain
    func flatMap(f: A -> ContextB) -> ContextB

    // (>>) :: m a -> m b -> m b
    // TODO: Need a better name
    func use(context: ContextB) -> ContextB

    // x >> y = x >>= \_ -> y
    // fail :: String -> m a
    // fail msg = error msg

    // flatten, join
    func flatten() -> ContextA
}

// (>>=) :: m a -> (a -> m b) -> m b
infix operator >>= { associativity left }

func >>= <A, Context:Monad>(contextA: Context, f: A -> Context) -> Context {
    // TODO
    return contextA
//    return contextA.flatMap(f)
}

// (>>) :: (Monad m) => m a -> m b -> m b
// m >> n = m >>= \_ -> n
infix operator >> { associativity left }

func >> <Context:Monad>(contextA: Context, contextB: Context) -> Context {
    // TODO
    return contextA
//    return contextA.use(contextB)
}