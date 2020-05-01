//
//  MainViewInput.swift
//  AnimationsTest
//
//  Created by Enoxus on 26.04.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
import UIKit

protocol MainViewInput: AnyObject {
    
    /// tells view to display table view
    func displayTableView()
    
    /// tells view to display loading view
    func displayLoadingView()
    
    /// tells view to completely refresh its data
    func reloadData()
    
    /// tells view to reload content according to the update informations
    /// - Parameters:
    ///   - deletions: indices of deletions
    ///   - insertions: indices of insertions
    ///   - modifications: indices of modifications
    func reloadData(deletions: [IndexPath], insertions: [IndexPath], modifications: [IndexPath])
    
    /// register the datasource for table view
    /// - Parameter dataSource: data source to be registered
    func registerDataSource(_ dataSource: UITableViewDataSource)
    
    /// tells to display detail view to its full size immediately
    func displayDetailView(for hero: HeroDto, at indexPath: IndexPath)
    
    /// tells view to display detail view as card
    /// - Parameters:
    ///   - hero: hero model
    ///   - indexPath: source index path
    func displayDetailViewAsCard(for hero: HeroDto, at indexPath: IndexPath)
    
    /// tells view to update pan animation completion percentage
    /// - Parameter percentage:pan animation completion percentage
    func updatePanAnimationPercentage(with percentage: Double)
    
    /// tells view to finish pan animation
    /// - Parameter percentage: completion percentage to be finished at
    func finishPanAnimation(at percentage: Double)
    
    func fireHapticImpact()
}
