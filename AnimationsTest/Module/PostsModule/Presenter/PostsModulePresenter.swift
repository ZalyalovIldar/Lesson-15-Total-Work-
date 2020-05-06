//
//  PostsModulePresenter.swift
//  AnimationsTest
//
//  Created by Евгений on 03.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation

class PostsModulePresenter: PostsModuleViewOutput, PostsModuleInteractorOutput {

    weak var view: PostsModuleViewInput!
    var interactor: PostsModuleInteractorInput!
    var router: PostModuleRouterInput!
    
    func loadPosts() {
        interactor.loadPostsFromDatabase()
    }
    
    func didFinishLoadingPostsFromNetwork(posts: [Post]) {
        interactor.convertPostsToDto(posts: posts)
    }
    
    func didFinishConvertingPostsToDto(posts: [PostDto]) {
        
        interactor.savePostsToDatabase(posts: posts)
        view.didFinishLoadingPosts(posts: posts)
    }
    
    func didFinishLoadingPostsFromDatabase(posts: [PostDto]) {
        
        if posts.isEmpty {
            interactor.loadPostsFromNetwork()
        } else {
            view.didFinishLoadingPosts(posts: posts)
        }
    }
    
    func editButtonPressed(for post: PostDto) {
        router.editButtonPressed(for: post)
    }
    
    func deleteButtonPressed(for post: PostDto) {
        interactor.deletePost(post: post)
    }
    
    func didFinishDeletingPost() {
        view.didFinishDeletingPost()
    }
    
}
