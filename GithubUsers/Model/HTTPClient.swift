//
//  HTTPClient.swift
//  GithubUsers
//
//  Created by Crystal on 2021/10/5.
//

import Foundation

enum RequestType {
    
    case allUsers
    case oneUser(login: String)
    
    func getURL() -> URL? {
        
        let urlString = "https://api.github.com/users"
        
        switch self {
        
        case .allUsers: 
            return URL(string: urlString)
            
        case .oneUser(let login):
            return URL(string: "\(urlString)/\(login)")
        }
    }
}

class HTTPClient {
    
    let session: URLSession = URLSession(configuration: .default)
    
    typealias APICompletionHandler = ([User]?, Error?) -> Void
    
    func request(type: RequestType,
                 completion: @escaping APICompletionHandler) {
        
        guard let url = type.getURL() else { return }
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                guard let httpResponse = response as? HTTPURLResponse else { return }
                if httpResponse.statusCode == 200 {
                    print("success")
                    do {
                        switch type {
                        case .allUsers:
                            let users = try JSONDecoder().decode([User].self, from: data)
                            completion(users, nil)
                        case .oneUser:
                            let user = try JSONDecoder().decode(User.self, from: data)
                            completion([user], nil)
                        }
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
