//
//  UIImage+Extension.swift
//  PIano
//
//  Created by Khoa Pham on 12/4/15.
//  Copyright © 2015 Fantageek. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
    convenience init(color: UIColor, size: CGSize = CGSizeMake(1, 1)) {
        let rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(CGImage: image.CGImage!)
    }
}
