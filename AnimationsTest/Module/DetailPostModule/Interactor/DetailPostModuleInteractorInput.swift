//
//  DetailPostModuleInteractorInput.swift
//  AnimationsTest
//
//  Created by Евгений on 06.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation

protocol DetailPostModuleInteractorInput {
    
    func saveChanges(of post: PostDto, delegate: PostsModuleViewControllerEditingProtocol)
}
