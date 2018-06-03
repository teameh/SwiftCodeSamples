//
//  AnimatingConstraintsVC.swift
//  CodeSamples
//
//  Created by Tieme van Veen on 03/06/2018.
//  Copyright © 2018 Tieme van Veen. MIT Licence
//

import UIKit

class AnimatingConstraintsVC: UIViewController {

    @IBOutlet weak var yellowHeight: NSLayoutConstraint!
    @IBOutlet weak var greenHeight: NSLayoutConstraint!

    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var velocityLabel: UILabel!
    @IBOutlet weak var dampingLabel: UILabel!
    @IBOutlet weak var easingLabel: UILabel!
    @IBOutlet weak var easingSwitch: UISegmentedControl!
    @IBOutlet weak var button: UIButton!

    var isExpanded = true

    var duration : Double = 1
    var velocity : CGFloat = 0.5
    var damping : CGFloat = 0.5

    var easings : [String: UIViewAnimationOptions ] = [
        "EaseIn": UIViewAnimationOptions.curveEaseIn,
        "EaseOut": UIViewAnimationOptions.curveEaseOut,
        "EaseInOut": UIViewAnimationOptions.curveEaseInOut,
        "Linear": UIViewAnimationOptions.curveLinear,
    ];
    var easing : (key: String, value: UIViewAnimationOptions) = ("EaseIn", UIViewAnimationOptions.curveEaseIn)

    override func viewDidLoad() {
        super.viewDidLoad()

        easingSwitch.removeAllSegments()
        easings.forEach {
            easingSwitch.insertSegment(withTitle: $0.key, at: 0, animated: false)
        }
        easingSwitch.selectedSegmentIndex = 0
        easingLabel.text = "EaseIn"
    }

    @IBAction func changeDuration(_ sender: Any, forEvent event: UIEvent) {
        guard let slider = sender as? UISlider else {
            return;
        }

        duration = Double(slider.value)
        durationLabel.text = "\(String(format: "%.1f", duration))"
    }
    
    @IBAction func changeVelocity(_ sender: Any, forEvent event: UIEvent) {
        guard let slider = sender as? UISlider else {
            return;
        }

        velocity = CGFloat(slider.value)
        velocityLabel.text = "\(String(format: "%.1f", velocity))"
    }

    @IBAction func changeDamping(_ sender: Any, forEvent event: UIEvent) {
        guard let slider = sender as? UISlider else {
            return;
        }

        damping = CGFloat(slider.value)
        dampingLabel.text = "\(String(format: "%.1f", damping))"
    }

    @IBAction func changeEasing(_ sender: Any, forEvent event: UIEvent) {
        if let title = easingSwitch.titleForSegment(at: easingSwitch.selectedSegmentIndex),
            let ease = easings.first(where: { $0.key == title }) {
            easing = ease
            easingLabel.text = ease.key
        } else {
            print("No ease found with key \(title ?? "")")
        }
    }

    @IBAction func toggleYellow(_ sender: Any) {
        isExpanded = !isExpanded

        // Animate yellow and toggle button label
        self.yellowHeight.constant = isExpanded ? 128 : 0
        self.view.setNeedsUpdateConstraints()
        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: damping,
            initialSpringVelocity: velocity,
            // User chooses how to ease yellow
            options: easing.value,
            animations: {
                self.button.setTitle("\(self.isExpanded ? "Hide" : "Show") yellow and green", for: .normal)
                self.view.layoutIfNeeded()
        })

        // Animate green
        self.greenHeight.constant = isExpanded ? 128 : 0
        self.view.setNeedsUpdateConstraints()
        UIView.animate(
            withDuration: duration,
            delay: 0,
            usingSpringWithDamping: damping,
            initialSpringVelocity: velocity,
            // Green always eases linear
            // TODO - THIS IS NOT WORKING... WHY?
            options: UIViewAnimationOptions.curveLinear,
            animations: {
                self.view.layoutIfNeeded()
            })
    }
}

