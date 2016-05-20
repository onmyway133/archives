//
//  WeakContainer.swift
//  Pods
//
//  Created by Khoa Pham on 9/27/15.
//
//

import Foundation

struct WeakContainer<T: AnyObject> {
    weak var value: T?
}