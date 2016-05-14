//
//  Note.swift
//  PIano
//
//  Created by Khoa Pham on 12/4/15.
//  Copyright © 2015 Fantageek. All rights reserved.
//

import Foundation

enum NoteType: Int {
    case Do, Re, Mi, Fa, Sol, La, Ti

    static let count: Int = {
        var max: Int = 0
        while let _ =  NoteType(rawValue: ++max) {}
        return max
    }()
}
