//
//  Dispatch.swift
//  Pods
//
//  Created by Khoa Pham on 9/29/15.
//
//

import Foundation

struct Dispatch {
    static func mainQueue() -> dispatch_queue_t {
        return dispatch_get_main_queue()
    }

    static func async(queue: dispatch_queue_t!, block: dispatch_block_t!) {
        dispatch_async(queue, block)
    }
}