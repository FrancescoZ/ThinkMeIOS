//
//  Config.swift
//  CertiWine
//
//  Created by Francesco Zanoli on 05/03/2018.
//  Copyright © 2018 CertiWine. All rights reserved.
//

import Foundation
import CoreBluetooth

enum Config{
  static let APIUrl = "https://thinkme.herokuapp.com"
  static var Auth = ""
  static var ID = ""
  
  static var idVar = "idUserThinkMe"
  static var authVar = "authThinkMe"
  static var uuidVar = "uuidThinkMe"
  
  static var BEAN_NAME = "ThinkMe"
  static var BEAN_SCRATCH_UUID =
    CBUUID(string: "a495ff21-c5b1-4b44-b512-1370f02d74de")
  static var BEAN_SERVICE_UUID =
    CBUUID(string: "a495ff20-c5b1-4b44-b512-1370f02d74de")
  
  
}
