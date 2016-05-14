//
//  UIButton+Extension.swift
//  PIano
//
//  Created by Khoa Pham on 12/4/15.
//  Copyright © 2015 Fantageek. All rights reserved.
//

import Foundation
import UIKit

public extension UIButton {
    public class func makeWhiteNote() -> UIButton {
        return makeNote(UIColor.whiteColor())
    }

    public class func makeBlackNote() -> UIButton {
        return makeNote(UIColor.blackColor())
    }

    private class func makeNote(color: UIColor) -> UIButton {
        let note = UIButton()

        note.setBackgroundImage(UIImage(color: color), forState: .Normal)
        note.setBackgroundImage(UIImage(color: UIColor.grayColor()), forState: .Highlighted)

        return note
    }
}
