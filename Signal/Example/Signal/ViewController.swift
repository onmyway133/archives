//
//  ViewController.swift
//  Signal
//
//  Created by Khoa Pham on 12/30/2015.
//  Copyright (c) 2015 Khoa Pham. All rights reserved.
//

import UIKit
import Signal

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let s = Signal<String>()

        s.subscribeNext { value in
            print(value)
        }

        s.sendNext("Happy New Year")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

