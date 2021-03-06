//  ProfileViewController
//  ThinkMe
//
//  Created by Francesco Zanoli on 03/03/2018.
//  Copyright © 2018 CertiWine.
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

class ProfileViewController: UIViewController{
  
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    profileImageView.roundedImage()
    NotificationCenter.default.addObserver(self, selector: #selector(refreshInterface), name: NSNotification.Name(rawValue: "refreshProfileView"), object: nil)
    refresh()
  }
  
  func refresh(){
    profileImageView.roundedImage()
    profileImageView.downloadedFrom(email: (Shared.User?.email)!)
    
//    profileImageView.layer.borderWidth = 1
//    profileImageView.layer.masksToBounds = false
//    profileImageView.layer.borderColor = UIColor.black.cgColor
    nameLabel.text = Shared.User?.fullName
    emailLabel.text = Shared.User?.email
  }
  
  @objc func refreshInterface(notification: Notification){
    refresh()
  }
  
  @IBAction func menuTouch(_ sender: UIButton) {
    let viewControllerType: ViewControllerType = .Menu
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushViewController"), object: viewControllerType)
  }
}
