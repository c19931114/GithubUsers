//
//  UserTableViewCellModel.swift
//  GithubUsers
//
//  Created by Crystal on 2021/10/5.
//

import Foundation

class UserTableViewCellModel {
    
    let name: String
    let type: String
    let imgURL: String
    
    // Dependency Injection (DI)
    init(_ user: User) {
        self.name = user.name ?? ""
        self.type = user.type 
        self.imgURL = user.avatar_url ?? ""
    }
    
}
