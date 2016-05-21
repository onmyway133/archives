//
//  UIStoryboardSegue+Extension.swift
//  Pods
//
//  Created by Khoa Pham on 12/16/15.
//  Copyright © 2015 Fantageek. All rights reserved.
//

import Foundation
import UIKit

// TODO: How to swizzle init ?
/*
extension UIStoryboardSegue {
    public override class func initialize() {
        struct Static {
            static var token: dispatch_once_t = 0
        }

        // Make sure this isn't a subclass
        if self !== UIStoryboardSegue.self {
            return
        }

        dispatch_once(&Static.token) {
            let originalSelector = Selector("initWithIdentifier:source:destination:")
            let swizzledSelector = Selector("ftg_initWithIdentifier:source:destination:")

            let originalMethod = class_getInstanceMethod(self, originalSelector)
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)

            let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))

            if didAddMethod {
                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        }
    }

    // MARK: - Method Swizzling

    class func ftg_init(identifier identifier: String!,
        source: UIViewController,
        destination: UIViewController) -> UIStoryboardSegue {

        return ftg_init(identifier: identifier,
            source: source,
            destination: destination.ftg_resolve())
    }
}
*/
