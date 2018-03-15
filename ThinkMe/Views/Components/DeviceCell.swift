//
//  DeviceCell.swift
//  ThinkMe
//
//  Created by Francesco Zanoli on 13/03/2018.
//  Copyright © 2018 ThinkMe. All rights reserved.
//

import UIKit

class DeviceCell: UITableViewCell {
  @IBOutlet weak var deviceLabel: UILabel!
  
  func setup(name: String){
    deviceLabel.text = name
  }
}

