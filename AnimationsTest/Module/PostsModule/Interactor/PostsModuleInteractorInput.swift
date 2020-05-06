//
//  PostsModuleInteractorInput.swift
//  AnimationsTest
//
//  Created by Евгений on 03.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation

protocol PostsModuleInteractorInput: AnyObject {
    
    func loadPostsFromDatabase()
    func loadPostsFromNetwork()
    func convertPostsToDto(posts: [Post])
    func savePostsToDatabase(posts: [PostDto])
}
