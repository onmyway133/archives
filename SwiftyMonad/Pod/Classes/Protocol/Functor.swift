//
//  Functor.swift
//  Pods
//
//  Created by Khoa Pham on 9/26/15.
//
//

import Foundation

// class Functor f where
public protocol Functor {
    typealias A
    typealias B
    typealias ContextA  // declare here for Applicative Functor and Monad to use
    typealias ContextB

    // fmap :: (a -> b) -> f a -> f b
    func fmap(f: A -> B) -> ContextB

    // of
    static func of(value: A) -> ContextA
}

// (<$>) :: (Functor f) => (a -> b) -> f a -> f b
// f <$> x = fmap f x
infix operator <^> { associativity left }

func <^><A, B, Context where Context:Functor>(f: A -> B, contextA: Context) -> Context {
    // TODO
    return contextA
//    return contextA.fmap(f)
}