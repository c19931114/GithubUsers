//
//  UserInfoViewController.swift
//  GithubUsers
//
//  Created by Crystal on 2021/10/5.
//

import UIKit

class UserInfoViewController: BaseViewController {

    private lazy var viewModel = SingleUserViewModel()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("X", for: .normal)
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 160 / 2
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .boldSystemFont(ofSize: 48)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var divider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loactionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var blogLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(with viewModel: SingleUserViewModel) {
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.user.value = viewModel.user.value
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViewModel()
    }
    
    private func setupUI() {
        
        view.addSubview(closeButton)
        view.addSubview(avatarImageView)
        view.addSubview(nameLabel)
        view.addSubview(divider)
        view.addSubview(loginLabel)
        view.addSubview(loactionLabel)
        view.addSubview(blogLabel)
        
        NSLayoutConstraint.activate([
            closeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24)
        ])
        NSLayoutConstraint.activate([
            avatarImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            avatarImageView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 24),
            avatarImageView.widthAnchor.constraint(equalToConstant: 160),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor)
        ])
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 24),
        ])
        NSLayoutConstraint.activate([
            divider.widthAnchor.constraint(equalTo: view.widthAnchor),
            divider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            divider.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            divider.heightAnchor.constraint(equalToConstant: 2)
        ])
        NSLayoutConstraint.activate([
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 16),
        ])
        NSLayoutConstraint.activate([
            loactionLabel.centerXAnchor.constraint(equalTo: loginLabel.centerXAnchor),
            loactionLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 16)
        ])
        NSLayoutConstraint.activate([
            blogLabel.centerXAnchor.constraint(equalTo: loactionLabel.centerXAnchor),
            blogLabel.topAnchor.constraint(equalTo: loactionLabel.bottomAnchor, constant: 16),
        ])
    }

    private func setupViewModel() {
        viewModel.user.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.setupData()
            }
        }
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    private func setupData() {
        
        guard let user = viewModel.user.value else { return }
        nameLabel.text = user.name ?? "no name"
        loginLabel.text = user.login
        loactionLabel.text = user.location ?? "no location"
        blogLabel.text = user.blog ?? "no blog"
        guard let urlString = user.avatar_url else { return }
        avatarImageView.load(urlString: urlString, login: user.login)
    }
}
