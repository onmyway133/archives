//
//  Event.swift
//  Pods
//
//  Created by Khoa Pham on 12/30/15.
//  Copyright © 2015 Fantageek. All rights reserved.
//

import Foundation

public enum Event<T> {
    case Next(value: T)
    case Failed(error: ErrorType)

    // MARK: Initialization
    public init(value: T) {
        self = .Next(value: value)
    }

    public init(error: ErrorType) {
        self = .Failed(error: error)
    }

    // Sync transformation
    public func map<U>(@noescape f: T -> U) -> Event<U> {
        switch self {
        case let .Next(value):
            return .Next(value: f(value))
        case let .Failed(error):
            return .Failed(error: error)
        }
    }

    public func flatMap<U>(@noescape f: T -> Event<U>) -> Event<U> {
        switch self {
        case let .Next(value):
            return f(value)
        case let .Failed(error):
            return .Failed(error: error)
        }
    }

    public func mapFailed(@noescape f: ErrorType -> ErrorType) -> Event<T> {
        switch self {
        case .Next:
            return self
        case let .Failed(error):
            return .Failed(error: f(error))
        }
    }

    // Async transformation
    public func map<U>(f: (T, U -> Void) -> Void) -> ((Event<U> -> Void) -> Void) {
        return { g in   // g: Event<U> -> Void
            switch self {
            case let .Next(value):
                f(value) { transformedValue in  // transformedValue: U
                    g(.Next(value: transformedValue))
                }
            case let .Failed(error):
                g(.Failed(error: error))
            }
        }
    }

    public func flatMap<U>(f: (T, Event<U> -> Void) -> Void) -> ((Event<U> -> Void) -> Void) {
        return { g in   // g: Event<U> -> Void
            switch self {
            case let .Next(value):
                return f(value, g)
            case let .Failed(error):
                return g(.Failed(error: error))
            }
        }
    }

    // MARK: Filter
    func filter(f: T -> Bool) -> ((Event<T> -> Void) -> Void) {
        return { g in
            switch self {
            case let .Next(value) where f(value):
                g(self)
            case .Failed:
                g(self)
            default:
                break
            }
        }
    }
}