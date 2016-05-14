//
//  Future.swift
//  Pods
//
//  Created by Khoa Pham on 1/2/16.
//
//

import Foundation

public struct Future<T> {
    let operation: (Event<T> -> Void) -> Void

    public init(operation: (Event<T> -> Void) -> Void) {
        self.operation = operation
    }

    public func start(completion: Event<T> -> Void) {
        operation() { event in
            completion(event)
        }
    }

    public func map<U>(f: T -> U) -> Future<U> {
        return Future<U> { completion in
            self.start { event in
                completion(event.map(f))
            }
        }
    }

    public func flatMap<U>(f: T -> Future<U>) -> Future<U> {
        return Future<U> { completion in
            self.start { event in
                switch event {
                case let .Next(value):
                    f(value).start(completion)
                case let .Failed(error):
                    completion(Event<U>.Failed(error: error))
                }
            }
        }
    }
}