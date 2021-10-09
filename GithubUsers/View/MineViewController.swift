//
//  MineViewController.swift
//  GithubUsers
//
//  Created by Crystal on 2021/10/5.
//

import UIKit

class MineViewController: BaseViewController {
    
    private var mineViewModel = MineViewModel()
    
    private lazy var bannerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 15/255, green: 37/255, blue: 73/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var logoImageView: UIImageView = {
        let image = UIImage(named: "github_docs")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 100 / 2
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var followImageView: UIImageView = {
        let image = UIImage(named: "follow")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var followLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailImageView: UIImageView = {
        let image = UIImage(named: "email")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        setupUI()
        setupViewModel()
    }
    
    private func setupUI() {
        
        view.addSubview(bannerView)
        bannerView.addSubview(logoImageView)
        view.addSubview(avatarImageView)
        view.addSubview(nameLabel)
        view.addSubview(loginLabel)
        view.addSubview(followImageView)
        view.addSubview(followLabel)
        view.addSubview(emailImageView)
        view.addSubview(emailLabel)
        
        NSLayoutConstraint.activate([
            bannerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bannerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bannerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bannerView.heightAnchor.constraint(equalToConstant: 200)
        ])
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: bannerView.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: bannerView.centerYAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: bannerView.leadingAnchor, constant: 24),
            logoImageView.topAnchor.constraint(equalTo: bannerView.topAnchor, constant: 48)
        ])
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            avatarImageView.centerYAnchor.constraint(equalTo: bannerView.bottomAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16)
        ])
        NSLayoutConstraint.activate([
            loginLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            loginLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8)
        ])
        NSLayoutConstraint.activate([
            followImageView.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            followImageView.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 16),
            followImageView.widthAnchor.constraint(equalToConstant: 24),
            followImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        NSLayoutConstraint.activate([
            followLabel.leadingAnchor.constraint(equalTo: followImageView.trailingAnchor, constant: 16),
            followLabel.centerYAnchor.constraint(equalTo: followImageView.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            emailImageView.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            emailImageView.topAnchor.constraint(equalTo: followImageView.bottomAnchor, constant: 16),
            emailImageView.widthAnchor.constraint(equalToConstant: 24),
            emailImageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        NSLayoutConstraint.activate([
            emailLabel.leadingAnchor.constraint(equalTo: followLabel.leadingAnchor),
            emailLabel.centerYAnchor.constraint(equalTo: emailImageView.centerYAnchor)
        ])
    }
    
    private func setupViewModel() {
        mineViewModel.user.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.setupData()
            }
        }
        mineViewModel.fetchData()
    }
    
    private func setupData() {
        
        guard let user = mineViewModel.user.value else { return }
        nameLabel.text = user.name
        loginLabel.text = user.login
        followLabel.attributedText = genrateFollowText()
        emailLabel.text = user.email ?? "none"
        guard let urlString = user.avatar_url else { return }
        avatarImageView.load(urlString: urlString, login: user.login)
    }
    
    private func genrateFollowText() -> NSMutableAttributedString? {
        
        guard let user = mineViewModel.user.value else { return nil }
        var string: NSMutableAttributedString
        
        let followersCount = user.followers ?? 0
        let followingCount = user.following ?? 0
        let countAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
                              NSAttributedString.Key.foregroundColor: UIColor.black]
        let followersCountString = NSMutableAttributedString(string: String(followersCount), 
                                                             attributes: countAttribute)
        let followingCountString = NSMutableAttributedString(string: String(followingCount), 
                                                             attributes: countAttribute)
        
        let followerText = followersCount > 1 ? " followers・" : " follower・"
        let followingText = followingCount > 1 ? " followings・" : " following・"
        let textAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18), 
                             NSAttributedString.Key.foregroundColor: UIColor.gray]
        let followerString = NSMutableAttributedString(string: followerText, 
                                                       attributes: textAttribute)
        let followingString = NSMutableAttributedString(string: followingText, 
                                                        attributes: textAttribute)
        
        string = followersCountString
        string.append(followerString)
        string.append(followingCountString)
        string.append(followingString)
        return string
    }
}
