//
//  UIImageView+Extension.swift
//  GithubUsers
//
//  Created by Crystal on 2021/10/8.
//

import UIKit

extension UIImageView {

    func load(urlString: String, login: String) {

        guard let url = URL(string: urlString) else {
            self.image = UIImage()
            return
        }

        guard let image = CacheManager.shared.imageCache.object(forKey: login as NSString) else {
            DispatchQueue.global().async { [weak self] in
                guard let data = try? Data(contentsOf: url),
                      let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self?.image = image
                    CacheManager.shared.imageCache.setObject(image, forKey: login as NSString)
//                    print("set cache image for key \(url)")
                }
            }
            return
        }
//        print("use cache image for key \(url)")
        self.image = image
    }
}
