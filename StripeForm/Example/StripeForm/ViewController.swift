//
//  ViewController.swift
//  StripeForm
//
//  Created by Khoa Pham on 12/28/2015.
//  Copyright (c) 2015 Khoa Pham. All rights reserved.
//

import UIKit
import StripeForm

class ViewController: UIViewController {
    var form: StripeForm!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupForm()
    }

    func setupForm() {
        form = StripeForm.makeForm()
        form.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(form)

        form.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 20).active = true
        form.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: -20).active = true
        form.topAnchor.constraintEqualToAnchor(view.topAnchor, constant: 200).active = true
    }
}

