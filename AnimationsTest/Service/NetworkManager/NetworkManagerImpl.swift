//
//  NetworkManagerImpl.swift
//  AnimationsTest
//
//  Created by Евгений on 03.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation

class NetworkManagerImpl: NetworkManager {
    
    func loadPostsFromNetwork(completion: @escaping ([Post]) -> Void) {
        
        var posts: [Post] = []
        
        guard let url = URL(string: Constants.postsUrl)
            else {
                completion(posts)
                return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                posts = try decoder.decode([Post].self, from: data)
                completion(posts)
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
}
