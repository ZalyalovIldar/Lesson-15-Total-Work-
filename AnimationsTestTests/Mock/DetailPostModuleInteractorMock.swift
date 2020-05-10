//
//  DetailPostInteractorMock.swift
//  AnimationsTestTests
//
//  Created by Евгений on 10.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
@testable import AnimationsTest

class DetailPostModuleInteractorMock: DetailPostModuleInteractorInput {
    
    var isSavingChanges = false
    
    func saveChanges(of post: PostDto, delegate: PostsModuleViewControllerEditingProtocol) {
        isSavingChanges = true
    }
}
