//  Search User View Controller
//  ThinkMe
//
//  Created by Francesco Zanoli on 03/03/2018.
//  Copyright © 2018 ThinkMe.
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

import UIKit

class SearchUserViewController: UIViewController{
  
  var filteredUsers = [User]()
  
  @IBOutlet weak var userTableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  override func viewDidLoad() {
    searchBar.delegate = self
    filteredUsers = []
    NotificationCenter.default.addObserver(self, selector: #selector(refreshTableView), name: NSNotification.Name(rawValue: "refreshAllUsersTableView"), object: nil)
    super.viewDidLoad()
  }
  
  @IBAction func menuTouch(_ sender: UIButton) {
    let viewControllerType: ViewControllerType = .Menu
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushViewController"), object: viewControllerType)
  }
}

extension SearchUserViewController: UITableViewDataSource, UITableViewDelegate {
  @objc func refreshTableView(notification: NotificationCenter){
    filteredUsers = Shared.Users
    userTableView.reloadData()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return filteredUsers.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
    cell.setup(name: filteredUsers[indexPath.row].fullName, email: filteredUsers[indexPath.row].email)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "getUser"), object: filteredUsers[indexPath.row].id)
    tableView.deselectRow(at: indexPath, animated: true)
    let viewControllerType: ViewControllerType = .DetailUser
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "pushViewController"), object: viewControllerType)
    
  }
}

extension SearchUserViewController: UISearchBarDelegate{
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText.isEmpty{
      Shared.Users.removeAll()
      userTableView.reloadData()
    }else{
      NotificationCenter.default.post(name: NSNotification.Name(rawValue: "searchUsers"), object: searchText.lowercased())
    }
  }
}
