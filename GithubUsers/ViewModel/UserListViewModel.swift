//
//  UserListViewModel.swift
//  GithubUsers
//
//  Created by Crystal on 2021/10/5.
//

import Foundation

class UserListViewModel {
    
    var users: Observable<[SingleUserViewModel]>
    var page: Int
    
    init() {
        
        self.users = Observable([])
        self.page = 0
    }
    
    func fetchData() {
        
        HTTPClient().request(type: .allUsers) { [weak self] (data, error) in
            
            guard let users = data else { return }
            self?.users.value = users.compactMap { SingleUserViewModel(user: $0) }
        }
    }
}

