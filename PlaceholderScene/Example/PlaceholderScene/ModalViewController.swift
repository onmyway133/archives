//
//  ModalViewController.swift
//  PlaceholderScene
//
//  Created by Khoa Pham on 12/16/15.
//  Copyright © 2015 Fantageek. All rights reserved.
//

import Foundation
import UIKit

class ModalViewController: UIViewController {

    @IBAction func dismissButtonTouched(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
