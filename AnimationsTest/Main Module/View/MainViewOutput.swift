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
    
    /// tells presener that user has tapped on the cell at given index path
    /// - Parameter indexPath: index of the target cell
    func didSelectRow(at indexPath: IndexPath)
    
    /// tells presenter that long press gesture was triggered
    /// - Parameter indexPath: index of the target cell
    func didLongPressedOnCell(at indexPath: IndexPath)
    
    /// tells presenter that animation completion percentage should be updated
    /// - Parameter percentage: value to update completion with
    func updatePanAnimationPercentage(with percentage: Double)
    
    /// tells presenter that animation should be finished
    /// - Parameter percentage: completion percentage to be finished at
    func finishPanAnimation(at percentage: Double)
}
