//  Manger User controller
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
import Foundation

extension ManagerController{
  
  
  @objc func loadUser(notification: Notification){
    API.getUser(withId: Shared.UserId, onSuccess: { usr in
      Shared.User = User(apiModel: usr as! API.User)
      if !(notification.object as! Bool){
        let viewControllerType: ViewControllerType = .DetailDevice
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushViewController"), object: viewControllerType)
      }
    }, onFailure: showError)
  }
  
  @objc func searchUsers(notification: Notification){
    API.search(email: notification.object as! String, onSuccess: { users in
      Shared.Users.removeAll()
      for usr in (users as! Array<API.User>){
        Shared.Users.append(User(apiModel: usr))
      }
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshAllUsersTableView"), object: nil)
    }, onFailure: showError)
  }
  
  @objc func getUser(notification: Notification){
    API.getUser(withId: notification.object as! String, onSuccess: { user in
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshUserDetail"), object: User(apiModel: user as! API.User))
    }, onFailure: showError)
  }
  
  @objc func pair(notification: Notification){
    if ((Shared.User?.paired) != nil) && (Shared.User?.validPair)! {
      API.pair(senderId: Shared.UserId, receiverId: notification.object as! String, onSuccess: { user in
        let viewControllerType: ViewControllerType = .Status
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushViewController"), object: viewControllerType)
      }, onFailure: showError)
    }else{
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshStatusView"), object: nil)
    }
  }
  
  @objc func depair(notification: Notification){
    if ((Shared.User?.paired) != nil) && (Shared.User?.validPair)! {
      API.deletePair(userId: Shared.UserId, onSuccess: { user in
        let viewControllerType: ViewControllerType = .Status
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushViewController"), object: viewControllerType)
      }, onFailure: showError)
    }else{
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshStatusView"), object: nil)
    }
  }
  
  @objc func poke(notification: Notification){
    if ((Shared.User?.paired) != nil) && (Shared.User?.validPair)! {
      API.poke(userId: Shared.UserId, onSuccess: {_ in 
      }, onFailure: showError)
    }else{
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshStatusView"), object: nil)
    }
  }
  
  @objc func getStatus(notification: Notification){
    if ((Shared.User?.paired) != nil) && (Shared.User?.validPair)! {
      API.getUser(withId: (Shared.User?.paired)!, onSuccess: { user in
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshStatusView"), object: User(apiModel: user as! API.User))
      }, onFailure: showError)
    }else{
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refreshStatusView"), object: nil)
    }
  }
}
