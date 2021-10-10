//
//  UserTableViewCell.swift
//  GithubUsers
//
//  Created by Crystal on 2021/10/5.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    private lazy var viewModel = SingleUserViewModel()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 48 / 2
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setupUI()
        setupViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImageView.image = nil
    }
    private func setupUI() {
        
        contentView.addSubview(avatarImageView)
        contentView.addSubview(loginLabel)
        contentView.addSubview(typeLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            avatarImageView.heightAnchor.constraint(equalToConstant: 48),
            avatarImageView.widthAnchor.constraint(equalToConstant: 48)
        ])
        NSLayoutConstraint.activate([
            loginLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -12),
            loginLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
        ])
        NSLayoutConstraint.activate([
            typeLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 12),
            typeLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
        ])
    }
    
    private func setupViewModel() {
        viewModel.user.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.setupData()
            }
        }
    }

    func configCell(with cellModel: SingleUserViewModel) {
        viewModel.user.value = cellModel.user.value
    }
    
    private func setupData() {
        
        guard let user = viewModel.user.value else { return }
        loginLabel.text = user.login
        typeLabel.text = user.type
        guard let urlString = user.avatar_url else { return }
        avatarImageView.load(urlString: urlString, login: user.login)
    }
}
