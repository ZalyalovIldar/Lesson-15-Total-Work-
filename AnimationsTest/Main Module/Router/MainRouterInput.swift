//
//  MainRouterInput.swift
//  AnimationsTest
//
//  Created by Enoxus on 26.04.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation

protocol MainRouterInput: AnyObject {
    
    /// tells router to show renaming alert
    /// - Parameters:
    ///   - name: initial name to insert into textfield
    ///   - indexPath: index path of the cell that is being edited
    func showRenamingAlert(initial name: String, indexPath: IndexPath)
    
    /// tells router to show error alert
    /// - Parameter text: text to display in message
    func showErrorAlert(text: String)
}
