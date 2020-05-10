//
//  PostModuleRouter.swift
//  AnimationsTest
//
//  Created by Евгений on 06.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
import UIKit

class PostsModuleRouter: PostsModuleRouterInput {
    
    weak var view: UIViewController!
    
    func editButtonPressed(for post: PostDto) {
        view.performSegue(withIdentifier: Constants.toDetailPostViewSegueName, sender: post)
    }
}
