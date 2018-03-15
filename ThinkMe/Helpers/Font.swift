//
//  Font.swift
//  CertiWine
//
//  Created by Francesco Zanoli on 04/03/2018.
//  Copyright © 2018 CertiWine. All rights reserved.
//

import Foundation
import UIKit

enum Font: String {
  
  case montserratLight = "Montserrat-Light"
  case montserratRegular = "Montserrat-Regular"
  
  var type: String {
    switch self {
    case .montserratLight:
      return "otf"
    case .montserratRegular:
      return "ttf"
    }
  }
  
  func get(size: CGFloat = 15.0) -> UIFont {
    return UIFont(name: self.rawValue, size: size)!
  }
  
}
