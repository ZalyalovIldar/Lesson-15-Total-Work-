//
//  DetailPostRouterMock.swift
//  AnimationsTestTests
//
//  Created by Евгений on 10.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
@testable import AnimationsTest

class DetailPostModuleRouterMock: DetailPostModuleRouterInput {
    
    var isEndingEditing = false
    var isEndingEditingWithUpdate = false
    
    func endEditing() {
        isEndingEditing = true
    }
    
    func endEditingWithUpdate(delegate: PostsModuleViewControllerEditingProtocol) {
        isEndingEditingWithUpdate = true
    }
}
