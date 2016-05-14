//
//  ViewController.swift
//  SwiftyMonad
//
//  Created by Khoa Pham on 09/26/2015.
//  Copyright (c) 2015 Khoa Pham. All rights reserved.
//

import UIKit
import SwiftyMonad

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let m = Box<Int>(value: 1)
        let n = m.fmap {
            v in
            v * 2
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

