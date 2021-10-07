//
//  HTTPClient.swift
//  GithubUsers
//
//  Created by Crystal on 2021/10/5.
//

import Foundation

class HTTPClient {
    
    private lazy var baseUrl: URL = {
        return URL(string: "https://api.github.com/users")!
    }()
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    typealias APICompletionHandler = ([User]?, Error?) -> Void
    
    func fetchAPIData(completion: @escaping APICompletionHandler) {
                
        var request = URLRequest(url: baseUrl)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                guard let httpResponse = response as? HTTPURLResponse else { return }
                if httpResponse.statusCode == 200 {
                    print("success")
                    do {
                        let users = try JSONDecoder().decode([User].self, from: data)
                        completion(users, nil)
                    } catch let jsonError {
                        print("failed to decode")
                        completion(nil, jsonError)
                    }
                } else {
                    print(httpResponse.statusCode)
                    return
                }
            } else if let error = error {
                print("failed to fetch")
                completion(nil, error)
            }
            
        }
        
        task.resume()
    }
}
