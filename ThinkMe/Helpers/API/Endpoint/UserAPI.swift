//  User API
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
import Moya


extension API {
  
  enum UserAPI{
    case getUser(withId: String)
    
    case createUser(email: String, name: String, passwrd: String, passwrdConfirmation: String)
    case createUserFacebook(email: String, name: String, token: String)
    
    case login(email: String, passwrd: String)
    case loginFacebook(email: String)
    
    case search(email: String)
    
    case pair(senderId: String, receiverId: String)
    case deletePair(userId: String)
    case ack(senderId: String, receiverId: String)
    case poke(userId: String)
  }
}

// MARK: - TargetType Protocol Implementation
extension API.UserAPI: TargetType {
  var baseURL: URL { return URL(string: Config.APIUrl)! }
  var path: String {
    switch self {
    case .getUser(let userId):
      return "/users/\(userId)"
    case .createUser(_, _, _, _):
      return "/users"
    case .createUserFacebook(_, _, _):
      return "/usersfacebook"
    case .login(_, _):
      return "/authenticate"
    case .loginFacebook(_):
      return "/authenticatefacebook"
    case .search(_):
      return "/search"
    case .pair(let senderId, _):
      return "/users/\(senderId)/pair"
    case .deletePair(let userId):
      return "/users/\(userId)/pair"
    case .ack(_, let receiverId):
      return "/users/\(receiverId)/pair/ack"
    case .poke(let userId):
      return "/users/\(userId)/poke"
    }
  }
  var method: Moya.Method {
    switch self {
    case .getUser, .poke:
      return .get
    case .createUser, .createUserFacebook, .ack, .pair:
      return .put
    case .login, .loginFacebook, .search:
      return .post
    case .deletePair:
      return .delete
    }
  }
  var task: Task {
    switch self {
    case .getUser, .poke, .deletePair:
      return .requestPlain
    case let .createUser(email, name, passwrd, passwrdConfirmation):
      return .requestParameters(parameters: ["email": email, "password": passwrd, "name": name, "passwordConf": passwrdConfirmation], encoding: JSONEncoding.default)
    case let .createUserFacebook(email, name, token):
      return .requestParameters(parameters: ["email": email, "facebook": token, "name": name],
                                encoding: JSONEncoding.default)
    case let .login(email,passwrd):
      return .requestParameters(parameters: ["email": email, "password": passwrd],
                                encoding: JSONEncoding.default)
    case let .loginFacebook(email):
      return .requestParameters(parameters: ["email": email],
                                encoding: JSONEncoding.default)
    case .search(let email):
      return .requestParameters(parameters: ["email": email],
                                encoding: JSONEncoding.default)
    case .pair(_, let receiverId):
      return .requestParameters(parameters: ["receiverId": receiverId],
                                encoding: JSONEncoding.default)
    case .ack(let senderId, _):
      return .requestParameters(parameters: ["senderId": senderId],
                                encoding: JSONEncoding.default)
    }
  }
  var headers: [String: String]? {
    return ["Content-type": "application/json",
            "x-access-token": Config.Auth ]
  }
  var sampleData: Data {
    switch self {
    default:
      return "data".utf8Encoded
    }
  }
}
