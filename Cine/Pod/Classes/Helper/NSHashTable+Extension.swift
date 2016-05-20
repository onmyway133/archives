//
//  NSHashTable+Extension.swift
//  Pods
//
//  Created by Khoa Pham on 9/28/15.
//
//

import Foundation

extension NSHashTable {
    func forEach(body: (element: AnyObject) -> Void) {
        for item in self.allObjects {
            body(element: item)
        }
    }
}