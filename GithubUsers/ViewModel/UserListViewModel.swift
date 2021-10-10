//
//  UserListViewModel.swift
//  GithubUsers
//
//  Created by Crystal on 2021/10/5.
//

import Foundation

class UserListViewModel {
    
    var users: Observable<[SingleUserViewModel]>
    var shouldDisplayedCount: Int = 0
    private var page: Int = 1
    private let pageMaxDisplayCount: Int = 16
    
    init() {
        
        self.users = Observable([])
    }
    
    func fetchData() {
        
        HTTPClient().request(type: .allUsers) { [weak self] (data, error) in
            
            guard let self = self,
                  let users = data else { return }
            self.users.value = users.compactMap { SingleUserViewModel(user: $0) }
        }
    }
    
    func shouldLoadMore() -> Bool {
        let totalCount = users.value?.count ?? 0
        let totalPageCount = ceil(Double(totalCount) / Double(pageMaxDisplayCount))
        if page < Int(totalPageCount) {
            return true
        } else {
            return false
        }
    }
    
    func updateCount(completion: @escaping () -> Void) {
        guard shouldLoadMore() else { return }
        page += 1
        completion()
    }
    
    func getDisplayedCount() -> Int {
        if shouldLoadMore() {
            shouldDisplayedCount = page * pageMaxDisplayCount
        } else {
            shouldDisplayedCount = users.value?.count ?? 0
        }
        return shouldDisplayedCount
    }
}

