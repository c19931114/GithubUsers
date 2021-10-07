//
//  UserListViewController.swift
//  GithubUsers
//
//  Created by Crystal on 2021/10/5.
//

import UIKit

class UserListViewController: BaseViewController {
    
    private var userListViewModel = UserListViewModel()
    private let cellID = String(describing: UserTableViewCell.self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UserTableViewCell.self, 
                           forCellReuseIdentifier: cellID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViewModel()
    }
    
    private func setupUI() {
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    private func setupViewModel() {
        
        userListViewModel.users.bind { [weak self] _ in
            print("viewModel.users.bind")
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        userListViewModel.fetchUsers()
    }
}

extension UserListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return userListViewModel.users.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID = String(describing: UserTableViewCell.self)
        let reuseCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        guard let cell = reuseCell as? UserTableViewCell else { return reuseCell }
        cell.configCell(with: userListViewModel.users.value?[indexPath.row])
        return cell
    }
}

extension UserListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80 // UITableView.automaticDimension // 16+48+16
    }
}
