//
//  MainInteractorOutput.swift
//  AnimationsTest
//
//  Created by Enoxus on 26.04.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation

protocol MainInteractorOutput: AnyObject {
    
    /// tells presenter that heroes are fetched
    /// - Parameter result: array of fetched heroes
    func didFinishFetchingHeroes(result: [HeroDto])
    
    /// tells presenter that fetching finished with error
    /// - Parameter error: error that occured during fetching
    func didFinishFetchingHeroes(with error: Error)
    
    /// tells presenter that interactor just received an update notification
    /// - Parameters:
    ///   - new: current data after update
    ///   - deletions: indices of deleted items
    ///   - insertions: indices of inserted items
    ///   - modifications: indices of modified items
    func didReceiveUpdateNotification(new: [HeroDto], deletions: [Int], insertions: [Int], modifications: [Int])
}
