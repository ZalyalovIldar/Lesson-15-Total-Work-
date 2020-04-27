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
    /// - Parameter dataSource: <#dataSource description#>
    func registerDataSource(_ dataSource: UITableViewDataSource)
}
