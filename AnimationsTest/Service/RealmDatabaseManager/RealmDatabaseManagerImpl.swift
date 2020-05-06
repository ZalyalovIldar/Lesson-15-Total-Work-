//
//  RealmDatabaseManagerImpl.swift
//  AnimationsTest
//
//  Created by Евгений on 06.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
import RealmSwift

class RealmDatabaseManagerImpl: RealmDatabaseManager {
    
    fileprivate lazy var realm = try! Realm(configuration: .defaultConfiguration)
    
    func savePosts(posts: [PostDto]) {
        
        DispatchQueue.main.async {
            
            for post in posts {
                
                let postModel = post.toModel()
                try! self.realm.write {
                    self.realm.add(postModel)
                }
            }
        }
    }
    
    func getPosts() -> [PostDto] {
        
        let models = realm.objects(PostModel.self)
        var postsDto: [PostDto] = []
        
        for model in models {
            postsDto.append(model.toDto())
        }
        
        return postsDto
    }
    
    func updatePost(post: PostDto) {
        
        let postModel = post.toModel()
        
        try! realm.write {
            realm.add(postModel, update: .all)
            print("Model updated")
        }
    }
    
}
