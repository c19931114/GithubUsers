//
//  UserTableViewCellModel.swift
//  GithubUsers
//
//  Created by Crystal on 2021/10/5.
//

import Foundation

class UserTableViewCellModel {

    let login: String
    let id: Int
    let name: String
    let type: String
    let imgURL: String?
    
    // Dependency Injection (DI)
    init(_ user: User) {
        self.login = user.login
        self.id = user.id
        self.name = user.name ?? ""
        self.type = user.type 
        self.imgURL = user.avatar_url ?? ""
    }
    
}
