//
//  UserListViewController.swift
//  GithubUsers
//
//  Created by Crystal on 2021/10/5.
//

import UIKit

class UserListViewController: BaseViewController {
    
    private lazy var userListViewModel = UserListViewModel()
    private let cellID = String(describing: UserTableViewCell.self)
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = .zero
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
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        userListViewModel.fetchData()
    }
}

extension UserListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = userListViewModel.getDisplayedCount()
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        guard let cell = reuseCell as? UserTableViewCell, 
              let viewModels = userListViewModel.users.value else { return reuseCell }
        cell.configCell(with: viewModels[indexPath.row])
        return cell
    }
}

extension UserListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModels = userListViewModel.users.value else { return }
        let vc = UserInfoViewController(with: viewModels[indexPath.row])
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80 // UITableView.automaticDimension // 16+48+16
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            if userListViewModel.shouldLoadMore() {
                let spinner = UIActivityIndicatorView(style: .medium)
                spinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 80)
                tableView.tableFooterView = spinner
                spinner.startAnimating()
                tableView.tableFooterView?.isHidden = false
                userListViewModel.updateCount { [weak self] in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self?.tableView.reloadData()
                    }
                }
            }
        } else {
            tableView.tableFooterView = nil
        }
    }
}
