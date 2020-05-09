//
//  MainRouter.swift
//  AnimationsTest
//
//  Created by Enoxus on 26.04.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
import UIKit

class MainRouter: MainRouterInput {
    
    weak var view: UIViewController!
    weak var presenter: MainRouterOutput!
    
    //MARK: - Router Input
    func showRenamingAlert(initial name: String, indexPath: IndexPath) {
        
        let title = "Rename"
        let cancelTitle = "Cancel"
        let confirmTitle = "Confirm"
        let placeholder = "New name"
        
        let alert = UIAlertController(title: title, message: .none, preferredStyle: .alert)
        
        alert.addTextField { textField in
            
            textField.text = name
            textField.placeholder = placeholder
        }
        
        let okAction = UIAlertAction(title: confirmTitle, style: .default) { [weak self] _ in
            
            self?.presenter.userDidEnterNewName(for: indexPath, name: alert.textFields?.first!.text! ?? String())
        }
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .cancel)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        view.present(alert, animated: true)
    }
    
    func showErrorAlert(text: String) {
        
        let errorTitle = "Error"
        let dismissTitle = "OK"
        
        let alert = UIAlertController(title: errorTitle, message: text, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: dismissTitle, style: .default)
        
        alert.addAction(dismissAction)
        
        view.present(alert, animated: true)
    }
}
