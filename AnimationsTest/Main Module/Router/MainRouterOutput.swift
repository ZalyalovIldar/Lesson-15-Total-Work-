//
//  MainRouterOutput.swift
//  AnimationsTest
//
//  Created by Enoxus on 26.04.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation

protocol MainRouterOutput: AnyObject {
    
    /// tells presenter that user has confirmed the editing
    /// - Parameters:
    ///   - indexPath: index path of the object that is being edited
    ///   - name: new name
    func userDidEnterNewName(for indexPath: IndexPath, name: String)
}
