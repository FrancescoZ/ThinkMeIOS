//
//  StatusViewController.swift
//  ThinkMe
//
//  Created by Francesco Zanoli on 13/03/2018.
//  Copyright © 2018 ThinkMe. All rights reserved.
//
import UIKit

class StatusViewController: UIViewController{
  
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  
  @IBOutlet weak var profilePairedImageView: UIImageView!
  @IBOutlet weak var namePairedLabel: UILabel!
  @IBOutlet weak var emailPairedLabel: UILabel!
  
  @IBOutlet weak var arrowImageView: UIImageView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    profileImageView.roundedImage()
    profilePairedImageView.roundedImage()
    
    emailPairedLabel.text = "Not connected"
    namePairedLabel.text = ""
    NotificationCenter.default.addObserver(self, selector: #selector(refreshInterface), name: NSNotification.Name(rawValue: "refreshStatusView"), object: nil)
    refresh()
  }
  
  func refresh(){
    profileImageView.downloadedFrom(email: (Shared.User?.email)!)
    
    nameLabel.text = Shared.User?.fullName
    emailLabel.text = Shared.User?.email
  }
  
  @objc func refreshInterface(notification: Notification){
    refresh()
    guard let usr: User = notification.object as? User else{
      return
    }
    profilePairedImageView.downloadedFrom(email: usr.email)
    arrowImageView.image = #imageLiteral(resourceName: "arrow-blue")
    nameLabel.text = usr.fullName
    emailLabel.text = usr.email
  }
  
  @IBAction func menuTouch(_ sender: UIButton) {
    let viewControllerType: ViewControllerType = .Menu
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushViewController"), object: viewControllerType)
  }
  
  @IBAction func deleteTouch(_ sender: Any) {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "depair"), object: nil)
  }
}

