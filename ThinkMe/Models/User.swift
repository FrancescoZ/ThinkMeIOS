//
//  User.swift
//  ThinkMe
//
//  Created by Francesco Zanoli on 13/03/2018.
//  Copyright © 2018 ThinkMe. All rights reserved.
//

import Foundation

struct User{
  var id: String{
    get{
      return model._id
    }
  }
  var fullName: String {
    get {
      return model.name
    }
    set(newName) {
      model.name = newName
    }
  }
  
  var email: String {
    get {
      return model.email
    }
    set(newMail) {
      model.email = newMail
    }
  }
  
  var device: String?{
    get {
      return model.deviceNotificationToken
    }
    set(dev) {
      model.deviceNotificationToken = dev
    }
  }
  
  var paired: String?{
    get {
      return model.userPaired
    }
    set(newVal) {
      model.userPaired = newVal
    }
  }
  
  var validPair: Bool{
    get {
      return model.validPair
    }
    set(newVal) {
      model.validPair = newVal
    }
  }
  
  var model: API.User
  
  init(apiModel: API.User){
    model = apiModel
  }
  
}
