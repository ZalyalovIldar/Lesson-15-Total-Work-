//
//  DetailPostPresenterMock.swift
//  AnimationsTestTests
//
//  Created by Евгений on 10.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
@testable import AnimationsTest

class DetailPostModulePresenterMock: DetailPostModuleViewOutput, DetailPostModuleInteractorOutput {
    
    var isSavingPost = false
    var isFinishingSavingChanges = false
    
    func didPressSaveButton(on post: PostDto, isChanged: Bool, delegate: PostsModuleViewControllerEditingProtocol) {
        isSavingPost = true
    }
    
    func didFinishSavingChanges(delegate: PostsModuleViewControllerEditingProtocol) {
        isFinishingSavingChanges = true
    }   
}
