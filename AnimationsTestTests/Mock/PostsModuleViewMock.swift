//
//  PostsModuleViewMock.swift
//  AnimationsTestTests
//
//  Created by Евгений on 10.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
@testable import AnimationsTest

class PostsModuleViewMock: PostsModuleViewInput {
    
    var isLoadingPostsFinished = false
    var isDeletingPostsFinished = false
    
    func didFinishLoadingPosts(posts: [PostDto]) {
        isLoadingPostsFinished = true
    }
    
    func didFinishDeletingPost() {
        isDeletingPostsFinished = true
    }
}
