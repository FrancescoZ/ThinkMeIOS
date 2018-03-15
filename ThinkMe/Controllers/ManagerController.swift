//
//  ManagerController.swift
//  CertiWine
//
//  Created by Francesco Zanoli on 08/03/2018.
//  Copyright © 2018 CertiWine. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

enum ViewControllerType{
  case DetailUser
  case DetailDevice
  case Status
  case Devices
  case Profile
  case SearchUser
  case Menu
  case None
  case Login
  case Thanks
}

class ManagerController{
  init(currentViewController: UIViewController){
    Shared.currentViewController = currentViewController
    NotificationCenter.default.addObserver(self, selector: #selector(logout), name: NSNotification.Name(rawValue: "logout"), object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(loadUser), name: NSNotification.Name(rawValue: "refreshUser"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(searchUsers), name: NSNotification.Name(rawValue: "searchUsers"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(getUser), name: NSNotification.Name(rawValue: "getUser"), object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(getStatus), name: NSNotification.Name(rawValue: "getStatus"), object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(pair), name: NSNotification.Name(rawValue: "pairWith"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(depair), name: NSNotification.Name(rawValue: "depair"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(pair), name: NSNotification.Name(rawValue: "poke"), object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(handleError), name: NSNotification.Name(rawValue: "handleError"), object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(pushViewController), name: NSNotification.Name(rawValue: "pushViewController"), object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(dismiss), name: NSNotification.Name(rawValue: "dismiss"), object: nil)
    

  }
  
}

extension ManagerController{
  
  @objc func pushViewController(notification: Notification){
    let type: ViewControllerType = notification.object as! ViewControllerType
    let storyBoardName: String
    switch type{
    case .Profile:
      storyBoardName = "ProfileViewController"
    case .Menu, .None:
      storyBoardName = "MenuViewController"
    case .Login:
      storyBoardName = "LoginTutorialViewController"
    case .Thanks:
      storyBoardName = "ThanksViewController"
    case .Status:
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "getStatus"), object: nil)
      storyBoardName = "StatusViewController"
    case .SearchUser:
      storyBoardName = "SearchUserViewController"
    case .Devices:
      storyBoardName = "SearchDevicesViewController"
    case .DetailUser:
      storyBoardName = "DetailUserViewController"
    case .DetailDevice:
      storyBoardName = "ConnectedDeviceViewController"
    }
    let next = Shared.currentViewController?.storyboard?.instantiateViewController(withIdentifier: storyBoardName)
    Shared.oldViewController = Shared.currentViewController
    Shared.currentViewController?.present(next!, animated: true)
    Shared.currentViewController = next
  }
 
  @objc func handleError(notification: NotificationCenter){}
  
  @objc func logout(notification: NotificationCenter){
    let alertController = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: UIAlertControllerStyle.alert)
    alertController.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.cancel,handler: { (action: UIAlertAction!) in
      let viewControllerType: ViewControllerType = .Menu
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushViewController"), object: viewControllerType)
    }))
    alertController.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default,handler: { (action: UIAlertAction!) in
      KeychainWrapper.standard.removeObject(forKey: Config.authVar)
      KeychainWrapper.standard.removeObject(forKey: Config.idVar)
      let viewControllerType: ViewControllerType = .Thanks
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushViewController"), object: viewControllerType)
    }))
    Shared.currentViewController?.present(alertController, animated: true, completion: nil)
  }
  
  @objc func dismiss(notification: NotificationCenter){
    let temp = Shared.oldViewController
    Shared.oldViewController = Shared.currentViewController
    Shared.currentViewController?.dismiss(animated: true, completion: nil)
    Shared.currentViewController = temp
  }
  
  
  
  func showError(_ err:Error){
    let error = err as! API.ErrorCertiWine
    let alertController = UIAlertController(title: "Application Error", message: error.message, preferredStyle: UIAlertControllerStyle.alert)
    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
    Shared.currentViewController?.present(alertController, animated: true, completion: nil)
  }
}
