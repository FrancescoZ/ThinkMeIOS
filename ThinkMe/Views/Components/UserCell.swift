//
//  UserCell.swift
//  ThinkMe
//
//  Created by Francesco Zanoli on 13/03/2018.
//  Copyright © 2018 ThinkMe. All rights reserved.
//

import UIKit

enum CellState{
  case active
  case deactive
}

class UserCell: UITableViewCell {
  @IBOutlet weak var userNameLabel: UILabel!
  @IBOutlet weak var emailLabel: UILabel!
  @IBOutlet weak var pairImageView: UIImageView!
  
  func setup(name: String, email: String, state: CellState){
    switch state {
    case .deactive:
      userNameLabel.textColor = UIColor(red: 0.67, green: 0.67, blue: 0.67, alpha: 1.0)
      pairImageView.image = #imageLiteral(resourceName: "paired")
      self.backgroundColor = UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 0.3)
      self.accessoryType = .none
      break
    case .active:
      break
    }
    
    userNameLabel.text = name
    emailLabel.text = email
  }
}
