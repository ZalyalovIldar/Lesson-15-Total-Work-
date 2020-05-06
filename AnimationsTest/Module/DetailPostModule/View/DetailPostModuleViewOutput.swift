//
//  DetailPostModuleViewOutput.swift
//  AnimationsTest
//
//  Created by Евгений on 06.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation

protocol DetailPostModuleViewOutput {
    
    func didPressSaveButton(on post: PostDto, isChanged: Bool, delegate: PostsModuleViewControllerEditingProtocol)
}
