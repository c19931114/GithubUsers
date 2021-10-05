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
    
    let decoder = JSONDecoder()
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
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else { return }
                    if httpResponse.statusCode == 200 {
                        print("success")
                        do {
                            let apiData = try self.decoder.decode([User].self, from: data)
                            completion(apiData, nil)
                        } catch let error {
                            completion(nil, error)
                        }
                    } else {
                        print(httpResponse.statusCode)
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        
        task.resume()
    }
}
