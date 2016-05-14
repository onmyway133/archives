//
//  ApplicativeFunctor.swift
//  Pods
//
//  Created by Khoa Pham on 9/26/15.
//
//

import Foundation

// class (Functor f) => Applicative f where
public protocol ApplicativeFunctor : Functor {
    // pure :: a -> f a
    static func pure(value: A) -> ContextA

    // (<*>) :: f (a -> b) -> f a -> f b
    // TODO: Need to be more specific on how self must contain a function A -> B
    func apply(context: ContextA) -> ContextB
}

// (<*>) :: f (a -> b) -> f a -> f b
infix operator <*> { associativity left }

// TODO
//func <*><T, U>(f: (T -> U)?, a: T?) -> U? {
//    return a.apply(f)
//}