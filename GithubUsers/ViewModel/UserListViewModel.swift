//
//  UserListViewModel.swift
//  GithubUsers
//
//  Created by Crystal on 2021/10/5.
//

import Foundation

class UserListViewModel {
    
    var users: Observable<[UserTableViewCellModel]>
    
    init() {
        self.users = Observable([])
    }
    
    func fetchUsers() {
        HTTPClient().fetchAPIData { (data, error) in
            guard let users = data else { return }
            print("viewModel.fetchUsers")
            self.users.value = users.map { UserTableViewCellModel($0) }
        }
    }
}

