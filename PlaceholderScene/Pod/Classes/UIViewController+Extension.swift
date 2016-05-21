//
//  UIViewController+Extension.swift
//  Pods
//
//  Created by Khoa Pham on 12/16/15.
//  Copyright © 2015 Fantageek. All rights reserved.
//

import Foundation
import UIKit

public extension UIViewController {
    private struct AssociatedKeys {
        static var storyboardName = "storyboardName"
        static var viewControllerIdentifier = "viewControllerIdentifier"
    }

    @IBInspectable var ftg_storyboardName: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.storyboardName) as? String
        }

        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.storyboardName,
                    newValue as NSString?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }

    @IBInspectable var ftg_viewControllerIdentifier: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.viewControllerIdentifier) as? String
        }

        set {
            if let newValue = newValue {
                objc_setAssociatedObject(
                    self,
                    &AssociatedKeys.viewControllerIdentifier,
                    newValue as NSString?,
                    .OBJC_ASSOCIATION_RETAIN_NONATOMIC
                )
            }
        }
    }

    public func ftg_resolve() -> UIViewController {
        guard let storyboardName = ftg_storyboardName,
            viewControllerIdentifier = ftg_viewControllerIdentifier else {
                return self
        }

        let storyboard = UIStoryboard(name: storyboardName, bundle: self.nibBundle)
        return storyboard.instantiateViewControllerWithIdentifier(viewControllerIdentifier)
    }
}

public extension UIViewController {
    public override class func initialize() {
        struct Static {
            static var token: dispatch_once_t = 0
        }

        // Make sure this isn't a subclass
        if self !== UIViewController.self {
            return
        }

        dispatch_once(&Static.token) {
            let originalSelector = Selector("awakeAfterUsingCoder:")
            let swizzledSelector = Selector("ftg_awakeAfterUsingCoder:")

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

    func ftg_awakeAfterUsingCoder(aDecoder: NSCoder) -> AnyObject? {
        // FIXME: Got this "Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: '-[UIViewController _loadViewFromNibNamed:bundle:] loaded the "Fwz-tC-XWe-view-TKY-IP-Li9" nib but the view outlet was not set.'"

        return self

        /*
        print(ftg_storyboardName)
        print(ftg_viewControllerIdentifier)

        return self.ftg_resolve()
        */
    }
}
