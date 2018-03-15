//  Login Controller API
//  CertiWine
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

extension API{
  
  static func login(email: String,
                    password: String,
                    onSuccess success: @escaping (_ response: Any) -> Void,
                    onFailure failure: @escaping (_ error: Error) -> Void){
    API.userProvider.request(.login(email: email, passwrd: password)) { result in
      handleResponse(result: result,to: Authentication.self, onSuccess: success, onFailure: failure)
    }
  }
  
  static func loginFacebook(email: String,
                            fullName: String,
                            facebookToken: String,
                            onSuccess success: @escaping (_ response: Any) -> Void,
                            onFailure failure: @escaping (_ error: Error) -> Void){
    userProvider.request(.loginFacebook(email: email)) { result in
      handleResponse(result: result,to: Authentication.self, onSuccess: success, onFailure: failure)
    }
  }
  
  static func createFacebook(email: String,
                             fullName: String,
                             facebookToken: String,
                             onSuccess success: @escaping (_ response: Any) -> Void,
                             onFailure failure: @escaping (_ error: Error) -> Void){
    userProvider.request(.createUserFacebook(email: email, name: fullName, token: facebookToken)){ result in
      handleResponse(result: result,to: Authentication.self, onSuccess: success, onFailure: failure)
    }
  }
  
  static func createUser(email: String,
                         fullName: String,
                         password: String,
                         onSuccess success: @escaping (_ response: Any) -> Void,
                         onFailure failure: @escaping (_ error: Error) -> Void){
    userProvider.request(.createUser(email: email, name: fullName, passwrd: password, passwrdConfirmation: password )){ result in
      handleResponse(result: result,to: Authentication.self, onSuccess: success, onFailure: failure)
    }
  }
}
