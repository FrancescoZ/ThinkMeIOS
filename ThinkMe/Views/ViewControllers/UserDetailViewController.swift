//
//  UserDetailViewController.swift
//  ThinkMe
//
//  Created by Francesco Zanoli on 13/03/2018.
//  Copyright © 2018 ThinkMe. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController{
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  
  @IBOutlet weak var profileImage: UIImageView!
  
  @IBOutlet weak var pairButton: UIButton!
  
  override func viewDidLoad() {
    profileImage.roundedImage()
    //pairButton.layer.cornerRadius = pairButton.frame.size.width / 2
    NotificationCenter.default.addObserver(self, selector: #selector(refreshInterface), name: NSNotification.Name(rawValue: "refreshUserDetail"), object: nil)
  }
  
  @objc func refreshInterface(notification: Notification){
    let usr = notification.object as! User
    nameLabel.text = usr.fullName
    emailLabel.text = usr.email
    
    profileImage.downloadedFrom(email: usr.email )
  }
  
  @IBAction func backTouch(_ sender: Any) {
     NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismiss"), object: nil)
  }
}
