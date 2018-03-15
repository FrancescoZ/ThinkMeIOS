//
//  UserCell.swift
//  ThinkMe
//
//  Created by Francesco Zanoli on 13/03/2018.
//  Copyright © 2018 ThinkMe. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  
  func setup(name: String, email: String){
    userNameLabel.text = name
    emailLabel.text = email
  }
}
