//
//  PostsModuleInteractorOutput.swift
//  AnimationsTest
//
//  Created by Евгений on 03.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation

protocol PostsModuleInteractorOutput: AnyObject {
    
    func didFinishLoadingPostsFromNetwork(posts: [Post])
    func didFinishConvertingPostsToDto(posts: [PostDto])
    func didFinishLoadingPostsFromDatabase(posts: [PostDto])
}
