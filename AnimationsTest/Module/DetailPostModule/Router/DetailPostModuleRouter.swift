//
//  DetailPostModuleRouter.swift
//  AnimationsTest
//
//  Created by Евгений on 06.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
import UIKit

class DetailPostModuleRouter: DetailPostModuleRouterInput {
    
    weak var view: UIViewController!
    
    func endEditing() {
        self.view.navigationController?.popToRootViewController(animated: true)
    }
    
    func endEditingWithUpdate(delegate: PostsModuleViewControllerEditingProtocol) {
        
        delegate.didFinishEditing()
        self.view.navigationController?.popToRootViewController(animated: true)
    }
}
