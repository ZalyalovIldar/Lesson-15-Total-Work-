//
//  PostsModuleInteractorMock.swift
//  AnimationsTestTests
//
//  Created by Евгений on 10.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
@testable import AnimationsTest

class PostsModuleInteractorMock: PostsModuleInteractorInput {
    
    var isLoadedPostsFromDatabase = false
    var isLoadedPostsFromNetwork = false
    var isConvertedPostsToDto = false
    var isSavedPostsToDatabase = false
    var isDeletedPost = false
    
    func loadPostsFromDatabase() {
        isLoadedPostsFromDatabase = true
    }
    
    func loadPostsFromNetwork() {
        isLoadedPostsFromNetwork = true
    }
    
    func convertPostsToDto(posts: [Post]) {
        isConvertedPostsToDto = true
    }
    
    func savePostsToDatabase(posts: [PostDto]) {
        isSavedPostsToDatabase = true
    }
    
    func deletePost(post: PostDto) {
        isDeletedPost = true
    }
}
