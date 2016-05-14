//
//  Signal+Combine.swift
//  Pods
//
//  Created by Khoa Pham on 1/2/16.
//
//

import Foundation

public extension Signal {
    /**
     The returned signal sends a tuple containing all the inner signals Next event, but only when all the inner signals have sent at least 1 Next event. In case of Failed, terminate and forward the first Failed
     */
    func combineLatest() {

    }

    /**
     The returned signal sends a tuple containing all the inner signals Next event, but only when they all have new Event values. In case of Failed, terminate and forward the first Failed
     */
    func zip() {

    }
}