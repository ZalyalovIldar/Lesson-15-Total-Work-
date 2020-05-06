//
//  PostsModuleViewOutput.swift
//  AnimationsTest
//
//  Created by Евгений on 03.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation

protocol PostsModuleViewOutput: AnyObject {
    
    func loadPosts()
    func editButtonPressed(for post: PostDto)
}
