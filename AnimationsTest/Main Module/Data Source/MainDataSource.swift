//
//  MainDataSource.swift
//  AnimationsTest
//
//  Created by Enoxus on 26.04.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
import UIKit

class MainDataSource: NSObject, MainDataSourceInput, MainTableViewCellDelegate {
    
    var heroes: [HeroDto] = []
    
    weak var presenter: MainDataSourceOutput!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.nibName, for: indexPath) as! MainTableViewCell
        
        cell.configure(with: heroes[indexPath.row], delegate: self)
        
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale
        
        return cell
    }
    
    //MARK: - Cell Delegate
    func didLoadImage(data: Data, id: Int) {
        
        presenter.didLoadImage(data: data, id: id)
    }
}
