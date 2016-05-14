//
//  StripeForm.swift
//  Pods
//
//  Created by Khoa Pham on 12/28/15.
//  Copyright © 2015 Fantageek. All rights reserved.
//

import Foundation
import UIKit

public class StripeForm: UIView {
    
    @IBOutlet var headerView: UIView!
    @IBOutlet var foldView: UIView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var payButton: UIButton!
    @IBOutlet var foldViewHeightConstraint: NSLayoutConstraint!

    let foldViewHeight: CGFloat = 100

    public override func awakeFromNib() {
        super.awakeFromNib()

        layer.cornerRadius = 10

        [headerView, foldView].forEach { view in
            view.layer.borderColor = UIColor.grayColor().CGColor
            view.layer.borderWidth = 1.0
            view.layer.cornerRadius = 5
        }

        // Perspective for rotation related transform
        var perspectiveTransform = CATransform3DIdentity
        perspectiveTransform.m34 = 1 / -900
        layer.sublayerTransform = perspectiveTransform
    }

    // MARK: Action
    @IBAction func switchValueChanged(sender: UISwitch) {
        toggleFold(visible: sender.on)
    }


    @IBAction func payButtonTouched(sender: UIButton) {
        if textField.text?.isEmpty ?? false {
            shake()
            return
        } else {
            animatePayButton()
        }
    }

    // Logic
    func toggleFold(visible visible: Bool) {
        UIView.animateWithDuration(0.7, delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.2,
            options: .AllowAnimatedContent,
            animations: {
                self.foldViewHeightConstraint.constant = visible ? self.foldViewHeight : 0.0
                self.foldView.alpha = visible ? 1 : 0
                self.layoutIfNeeded()
            },
            completion: nil)
    }

    func shake() {
        // Translate on the X axis
        let translation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        translation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        translation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0]

        // Rotate around the Y axis
        let rotation = CAKeyframeAnimation(keyPath: "transform.rotation.y")
        rotation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        rotation.values = [-5, 5, -5, 5, -3, 3, -2, 2, 0].map {
            // to radian
            return CGFloat(Double($0) / 180.0 * M_PI)
        }

        let group = CAAnimationGroup()
        group.animations = [translation, rotation]
        group.duration = 0.6
        layer.addAnimation(group, forKey: "shake")
    }

    func animatePayButton() {
        animateButton(payButton, toTitle: "Sending", color: UIColor.darkGrayColor())
        delay(2.0) {
            self.animateButton(self.payButton, toTitle: "Sent", color: UIColor.greenColor())
        }
    }

    func animateButton(button: UIButton, toTitle title: String, color: UIColor) {
        let transition = CATransition()
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromTop
        transition.duration = 0.5
        
        button.titleLabel?.layer.addAnimation(transition, forKey: kCATransition)
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(color, forState: .Normal)
    }

    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}

extension StripeForm: UITextFieldDelegate {
    public func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()

        return true
    }
}

public extension StripeForm {
    class func makeForm() -> StripeForm {
        let bundle = NSBundle(forClass: self.classForCoder())
        return bundle.loadNibNamed("StripeForm", owner: nil, options: nil).first as! StripeForm
    }
}
