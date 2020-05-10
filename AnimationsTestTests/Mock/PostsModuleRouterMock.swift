//
//  PostsModuleRouterMock.swift
//  AnimationsTestTests
//
//  Created by Евгений on 10.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
@testable import AnimationsTest

class PostsModuleRouterMock: PostsModuleRouterInput {
    
    var isOpenedEditingView = false
    
    func editButtonPressed(for post: PostDto) {
        isOpenedEditingView = true
    }
}
