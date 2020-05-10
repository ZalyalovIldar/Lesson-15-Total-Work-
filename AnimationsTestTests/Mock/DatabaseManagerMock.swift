//
//  DatabaseManagerMock.swift
//  AnimationsTestTests
//
//  Created by Евгений on 10.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
@testable import AnimationsTest

class DatabaseManagerMock: RealmDatabaseManager {
    
    var isSavedPosts = false
    var isGotPosts = false
    var isUpdatedPost = false
    var isDeletedPost = false
    
    func savePosts(posts: [PostDto]) {
        isSavedPosts = true
    }
    
    func getPosts() -> [PostDto] {
        isGotPosts = true
        return []
    }
    
    func updatePost(post: PostDto) {
        isUpdatedPost = true
    }
    
    func deletePost(post: PostDto) {
        isDeletedPost = true
    }
}
