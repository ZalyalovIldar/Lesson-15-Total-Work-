//
//  PostsModulePresenterMock.swift
//  AnimationsTestTests
//
//  Created by Евгений on 10.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
@testable import AnimationsTest

class PostsModulePresenterMock: PostsModuleViewOutput, PostsModuleInteractorOutput {
    
    var idLoadingPosts = false
    var isEditingPost = false
    var isDeletingPost = false
    var isFinishingLoadingPostsFromDatabase = false
    var isFinishingLoadingPostsFromNetwork = false
    var isFinishingConvertingPostsToDto = false
    var isFinishingDeletingPost = false
    
    func loadPosts() {
        idLoadingPosts = true
    }
    
    func editButtonPressed(for post: PostDto) {
        isEditingPost = true
    }
    
    func deleteButtonPressed(for post: PostDto) {
        isDeletingPost = true
    }
    
    func didFinishLoadingPostsFromNetwork(posts: [Post]) {
        isFinishingLoadingPostsFromNetwork = true
    }
    
    func didFinishConvertingPostsToDto(posts: [PostDto]) {
        isFinishingConvertingPostsToDto = true
    }
    
    func didFinishLoadingPostsFromDatabase(posts: [PostDto]) {
        isFinishingLoadingPostsFromDatabase = true
    }
    
    func didFinishDeletingPost() {
        isFinishingDeletingPost = true
    }
}
