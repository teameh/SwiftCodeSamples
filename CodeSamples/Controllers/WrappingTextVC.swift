//
//  WrappingTextVC.swift
//  CodeSamples
//
//  Created by Tieme van Veen on 20/11/2018.
//  Copyright © 2018 Tieme van Veen (MIT Licence).
//

import UIKit

class WrappingTextVC: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()

    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.text = "ropcap example. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris aliquam vulputate ex. Fusce interdum ultricies justo in tempus. Sed ornare justo in purus dignissim, et rutrum diam pulvinar. Quisque tristique eros ligula, at dictum odio tempor sed. Fusce non nisi sapien. Donec libero orci, finibus ac libero ac, tristique pretium ex. Aenean eu lorem ut nulla elementum imperdiet. Ut posuere, nulla ut tincidunt viverra, diam massa tincidunt arcu, in lobortis erat ex sed quam. Mauris lobortis libero magna, suscipit luctus lacus imperdiet eu. Ut non dignissim lacus. Vivamus eget odio massa. Aenean pretium eget erat sed ornare. In quis tortor urna. Quisque euismod, augue vel pretium suscipit, magna diam consequat urna, id aliquet est ligula id eros. Duis eget tristique orci, quis porta turpis. Donec commodo ullamcorper purus. Suspendisse et hendrerit mi. Nulla pellentesque semper nibh vitae vulputate. Pellentesque quis volutpat velit, ut bibendum magna. Morbi sagittis, erat rutrum  Suspendisse potenti. Nulla facilisi. Praesent libero est, tincidunt sit amet tempus id, blandit sit amet mi. Morbi sed odio nunc. Mauris lobortis elementum orci, at consectetur nisl egestas a. Pellentesque vel lectus maximus, semper lorem eget, accumsan mi. Etiam semper tellus ac leo porta lobortis."
    textView.backgroundColor = .lightGray
    textView.textColor = .black
    view.addSubview(textView)

    textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
    textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
    textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true

    let dropCap = UILabel()
    dropCap.text = "D"
    dropCap.font = UIFont.boldSystemFont(ofSize: 60)
    dropCap.backgroundColor = .lightText
    dropCap.sizeToFit()
    textView.addSubview(dropCap)

    let imageView = UIImageView(image: UIImage(named: "so-icon"))
    imageView.backgroundColor = .lightText
    imageView.frame = CGRect(x: 0, y: 200, width: 0, height: 0)
    imageView.sizeToFit()
    textView.addSubview(imageView)

    textView.textContainer.exclusionPaths = [
      UIBezierPath(rect: dropCap.frame),
      UIBezierPath(rect: imageView.frame),
    ]
  }
}
