//
//  UserTableViewCell.swift
//  GithubUsers
//
//  Created by Crystal on 2021/10/5.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 48 / 2
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
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
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func configCell(with viewModel: UserTableViewCellModel?) {
        
        guard let user = viewModel else { return }
        loginLabel.text = user.login
        typeLabel.text = user.type
        guard let urlString = user.imgURL else { return }
        avatarImageView.load(urlString: urlString, login: user.login)
    }
}
