//
//  CacheManager.swift
//  GithubUsers
//
//  Created by Crystal on 2021/10/8.
//

import UIKit

class CacheManager {
    
    static let shared = CacheManager()
    let imageCache = NSCache<NSString, UIImage>()
}
