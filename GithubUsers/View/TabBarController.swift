//
//  TabBarController.swift
//  GithubUsers
//
//  Created by Crystal on 2021/10/5.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupTab()
        setupGesture()
    }
    
    private func setupTab() {

        let tabs: [Tab] = [.user, .mine]

        var controllers = [UIViewController]()
        tabs.forEach { (tab) in

            let controller = tab.controller
            controller.title = "Github"
            let navigationController = UINavigationController(rootViewController: controller)
            let item = UITabBarItem(title: tab.title, image: tab.image, selectedImage: tab.selectedImage)
            controller.tabBarItem = item
            controllers.append(navigationController)
        }
        setViewControllers(controllers, animated: false)
    }
    
    private func setupGesture() {
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
    }

    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        
        switch sender.direction {
        
        case .left: selectedIndex += 1
            
        case .right: selectedIndex -= 1
            
        default: break
        }
    }
}

enum Tab {

    case user
    case mine

    var title: String {

        switch self {
        case .user: return "User"
        case .mine: return "Mine"
        }
    }

    var controller: UIViewController {

        switch self {
        case .user: return UserListViewController()
        case .mine: return MineViewController()
        }
    }

    var image: UIImage {

        switch self {
        case .user: return UIImage(named: "tab_class") ?? UIImage()
        case .mine: return UIImage(named: "tab_chat") ?? UIImage()
        }

    }

    var selectedImage: UIImage {

        switch self {

        case .user: return UIImage(named: "tab_class_selected") ?? UIImage()
        case .mine: return UIImage(named: "tab_class_selected") ?? UIImage()
        }

    }
}
