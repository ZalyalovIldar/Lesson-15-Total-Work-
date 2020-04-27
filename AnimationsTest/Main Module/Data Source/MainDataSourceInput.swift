//
//  MainDataSourceInput.swift
//  AnimationsTest
//
//  Created by Enoxus on 26.04.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
import UIKit

protocol MainDataSourceInput: UITableViewDataSource {
    
    /// backing array of table view
    var heroes: [HeroDto] { get set }
}
