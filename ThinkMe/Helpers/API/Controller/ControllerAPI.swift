//  Controller API
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
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALING///
/// THE SOFTWARE.

import Foundation
import Moya
import Result

extension API{
  static let userProvider = MoyaProvider<UserAPI>()

  static func handleResponse<toDecode:Decodable>(result: Result<Moya.Response, MoyaError>,
                             to: toDecode.Type,
                             onSuccess success: @escaping (_ response: Any) -> Void,
                             onFailure failure: @escaping (_ error: Error) -> Void){
    switch result {
    case let .success(response):
      switch response.statusCode{
      case 200:
        do{
          let decoder = JSONDecoder()
          
          let responseJson = try response.map(to, using: decoder)
          success(responseJson)
        } catch _ {
          
        }
        break
      default:
        var message = ""
        do{
          let responseJson = try response.map(ErrorCertiWine.self, using: JSONDecoder.init())
          message = responseJson.message
        } catch _ {
          message = ErrorType.strangeError.rawValue
        }
        failure(ErrorCertiWine(message: message))
        break
      }
    default:
      failure(ErrorCertiWine(message: ErrorType.strangeError.rawValue))
      break
    }
  }
  
  enum ErrorType: String{
    case networkError = "There was a network error, check your connection or our server availability"
    case strangeError = "A Strange error happend, please try again or contact our customer service"
  }
}
