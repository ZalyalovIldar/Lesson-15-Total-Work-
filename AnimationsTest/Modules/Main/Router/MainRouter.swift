//
//  MainMainRouter.swift
//  Lesson-15-Total-Work-
//
//  Created by omeeer78 on 05/05/2020.
//  Copyright © 2020 ITIS. All rights reserved.
//

import UIKit

protocol MainRouterInput {
    func showErrorAlert(with title: String)
}

class MainRouter: MainRouterInput {
    
    weak var view: UIViewController!
    
    private let okButtonTitle = "Ok"
    private let cancelButtonTitle = "Cancel"
    
    //MARK: - MainRouterInput
    
    func showErrorAlert(with title: String) {
        
        let alert = UIAlertController(title: title, message: .none, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okButtonTitle, style: .cancel))
        view.present(alert, animated: true)
        
    }
}
