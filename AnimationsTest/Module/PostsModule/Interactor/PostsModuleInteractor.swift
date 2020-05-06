//
//  PostsModuleInteractor.swift
//  AnimationsTest
//
//  Created by Евгений on 03.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation

class PostsModuleInteractor: PostsModuleInteractorInput {
    
    weak var presenter: PostsModuleInteractorOutput!
    var networkManager: NetworkManager!
    var databaseManager: RealmDatabaseManager!
    
    func loadPostsFromNetwork() {
        
        networkManager.loadPostsFromNetwork() { [weak self] posts in
            self?.presenter.didFinishLoadingPostsFromNetwork(posts: posts)
        }
    }
    
    func convertPostsToDto(posts: [Post]) {
        
        var dtoPosts: [PostDto] = []
        posts.enumerated().forEach({dtoPosts.append($0.element.toDto())})
        presenter.didFinishConvertingPostsToDto(posts: dtoPosts)
    }
    
    func loadPostsFromDatabase() {
        
        let posts = databaseManager.getPosts()
        presenter.didFinishLoadingPostsFromDatabase(posts: posts)
    }
    
    func savePostsToDatabase(posts: [PostDto]) {
        databaseManager.savePosts(posts: posts)
    }
    
    func deletePost(post: PostDto) {
        
        databaseManager.deletePost(post: post)
        presenter.didFinishDeletingPost()
    }
    
}
