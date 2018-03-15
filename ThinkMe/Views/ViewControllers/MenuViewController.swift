//  MenuViewController
//  ThinkMe
//
//  Created by Francesco Zanoli on 03/03/2018.
//  Copyright © 2018 ThinkMe.
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit


class MenuViewController: UIViewController,CircleMenuDelegate{
  
  
  @IBOutlet weak var profileButton: UIButton!
  @IBOutlet weak var menuButton: CircleMenu!
  var closed = false

  @IBAction func profileTouch(_ sender: UIButton) {
    let viewControllerType: ViewControllerType = .Profile
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushViewController"), object: viewControllerType)
  }
  
  let items: [(icon: String, color: UIColor)] = [
    ("device", UIColor(red:0.19, green:0.57, blue:1, alpha:1)),
    ("search_filled", UIColor(red:0.96, green:0.23, blue:0.21, alpha:1)),
    ("status", UIColor(red:1, green:0.39, blue:0, alpha:1)),
    ("logout", UIColor(red:0.51, green:0.15, blue:1, alpha:1)),
    ]
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    menuButton.delegate = self
    menuButton.layer.cornerRadius = menuButton.frame.size.width / 2.0
  }
  
  override func viewDidAppear(_ animated: Bool) {
    menuButton.layer.cornerRadius = menuButton.frame.size.width / 2.0
    menuButton.sendActions(for: .touchUpInside)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func circleMenu(_ circleMenu: CircleMenu, willDisplay button: UIButton, atIndex: Int) {
    button.backgroundColor = items[atIndex].color
    
    button.setImage(UIImage(named: items[atIndex].icon), for: .normal)
    
    // set highlited image
    let highlightedImage  = UIImage(named: items[atIndex].icon)?.withRenderingMode(.alwaysTemplate)
    button.setImage(highlightedImage, for: .highlighted)
    button.tintColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.3)
  }
  
  func circleMenu(_ circleMenu: CircleMenu, buttonWillSelected button: UIButton, atIndex: Int) {
  }
  
  func circleMenu(_ circleMenu: CircleMenu, buttonDidSelected button: UIButton, atIndex: Int) {
    print("button did selected: \(atIndex)")
    var viewControllerType: ViewControllerType = .None
    switch atIndex {
    case 0:
      viewControllerType = .DetailDevice
    case 1:
      viewControllerType = .SearchUser
    case 2:
      viewControllerType = .Status
    case 3:
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "logout"), object: nil)
      return
    default:
      viewControllerType = .None
    }
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushViewController"), object: viewControllerType)
    
  }
  
  func menuCollapsed(_ circleMenu: CircleMenu){
    if (!closed){
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismiss"), object: nil)
    }
    closed = true
  }
  
}

