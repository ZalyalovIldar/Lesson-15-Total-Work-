//
//  MainViewOutput.swift
//  AnimationsTest
//
//  Created by Enoxus on 26.04.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation

protocol MainViewOutput: AnyObject {
    
    /// tells presenter that view did load
    func viewDidLoad()
    
    /// tells presenter that user pressed delete button at given index path
    /// - Parameter indexPath: index path where delete was requested
    func didPressedDelete(on indexPath: IndexPath)
    
    /// tells presenter that user pressed rename button at given index path
    /// - Parameter indexPath: index path where rename was requested
    func didPressedRename(on indexPath: IndexPath)
}
