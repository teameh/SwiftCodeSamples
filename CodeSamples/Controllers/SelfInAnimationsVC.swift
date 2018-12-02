//
//  SelfInAnimationsVC.swift
//  CodeSamples
//
//  Created by Tieme van Veen on 02/12/2018.
//  Copyright © 2018 Tieme van Veen (MIT Licence). All rights reserved.
//

import UIKit

class SelfInAnimationsVC: UIViewController {

  var label : UILabel!
  var yellow : UIButton!
  var blue : UIButton!
  var red : UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()

    print("--------------------\n- viewDidLoad")
    navigationItem.hidesBackButton = true

    let rect = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
    label = UILabel(frame: rect.insetBy(dx: 10, dy: 0).offsetBy(dx: 0, dy: 100))
    label.text = "Do we need to use [weak self] or \n[unowned self] when using UIView? \nTap the buttons to start an animation + dismiss the controller"
    label.textAlignment = .center
    label.numberOfLines = 4
    view.addSubview(label)

    // Set up 3 buttons, all calling their own animation method when tapped
    // When tapping the button will animate up a bit and when the animation is 50% done, the ViewController will be dismissed.
    yellow = setupButton(rect: rect.offsetBy(dx: 0, dy: 300), color: .yellow, title: "stong", titleColor: .black, selector: #selector(animateYellow))
    blue = setupButton(rect: rect.offsetBy(dx: 0, dy: 410), color: .blue, title: "[weak self]", titleColor: .white, selector: #selector(animateBlue))
    red = setupButton(rect: rect.offsetBy(dx: 0, dy: 520), color: .red, title: "[unowned self]", titleColor: .black, selector: #selector(animateRed))
  }

  func setupButton(rect: CGRect, color: UIColor, title: String, titleColor: UIColor, selector: Selector) -> UIButton {
    let button = UIButton(frame: rect)
    button.backgroundColor = color
    button.setTitle(title, for: .normal)
    button.setTitleColor(titleColor, for: .normal)
    button.addTarget(self, action: selector, for: .touchUpInside)
    view.addSubview(button)
    return button
  }

  /* Animation handler and completion handler with a strong self
   * OUTPUT:
   *   --------------------
   *   - viewDidLoad()
   *   - yellow animating
   *   - yellow completion
   *   - doSomething is called!
   *   - deinit
   **/
  @IBAction func animateYellow() {
    UIView.animate(withDuration: 4, animations: {
      print("- yellow animating")

      self.yellow.frame = self.yellow.frame.offsetBy(dx: 0, dy: -500 )
    }, completion: { finished in
      print("- yellow completion")
      // self is retained by the block because it is strongly captured
      // deinit is called after the completion block
      self.doSomething()
    })

    // While the animation is running, dismiss the viewcontroller
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
      self?.navigationController?.popViewController(animated: true)
    }
  }

  /* Animation handler and completion handler with an weak strong self
   * OUTPUT:
   *   --------------------
   *   - viewDidLoad()
   *   - blue animating
   *   - deinit
   *   - blue completion
   **/
  @IBAction func animateBlue() {
    UIView.animate(withDuration: 4, animations: { [weak self] in
      print("- blue animating")

      if let self = self {
        self.blue.frame = self.blue.frame.offsetBy(dx: 0, dy: -500 )
      }
    }, completion: { [weak self] finished in
      print("- blue completion")
      // self won't be retained by the completion block because it is weakly captured
      // deint is called before the completion block, because nothing retained self any more
      // self will be nil here, so doSomething won't be called
      self?.doSomething()
    })

    // While the animation is running, dismiss the viewcontroller
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
      self?.navigationController?.popViewController(animated: true)
    }
  }

  /* Animation handler and completion handler with a unowned strong self
   *   --------------------
   *   - viewDidLoad()
   *   - red animating
   *   - deinit
   *   - red completion, self == nil
   *   Fatal error: Attempted to read an unowned reference but the object was already deallocated
   **/
  @IBAction func animateRed() {
    UIView.animate(withDuration: 4, animations: { [unowned self] in
      print("- red animating")

      self.red.frame = self.red.frame.offsetBy(dx: 0, dy: -500 )
    }, completion: { [unowned self] finished in
      print("- red completion")
      // self won't be retained by the completion block because it is unowned captured
      // deint is called before the completion block, because nothing retained self any more
      // self will be nil here
      // This will crash! "Attempted to read an unowned reference but the object was already deallocated"
      self.doSomething()
    })

    // While the animation is running, dismiss the viewcontroller
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
      self?.navigationController?.popViewController(animated: true)
    }
  }

  // Will this be called?
  func doSomething() {
    print("- doSomething is called!")
  }

  deinit {
    print("- deinit")
  }
}

