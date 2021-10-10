//
//  SingleUserViewModel.swift
//  GithubUsers
//
//  Created by Crystal on 2021/10/5.
//

import Foundation

class SingleUserViewModel {
    
    var user: Observable<User>
    
    init() {
        self.user = Observable(nil)
    }
    
    convenience init(user: User) {
        self.init()
        self.user = Observable(user)
    }
    
    func fetchMyData() {
        
        HTTPClient().request(type: .oneUser(login: "c19931114")) { [weak self] (data, error) in
            
            guard let users = data, let me = users.first else { return }
            self?.user.value = me
        }
    }
}
