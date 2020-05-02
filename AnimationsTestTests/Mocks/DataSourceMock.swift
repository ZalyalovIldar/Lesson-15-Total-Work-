//
//  DataSourceMock.swift
//  AnimationsTestTests
//
//  Created by Enoxus on 02.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
import UIKit
@testable import AnimationsTest

class DataSourceMock: NSObject, MainDataSourceInput {
    
    var shouldUpdateHeroesArray = false
    
    var heroes: [HeroDto] = [HeroDto(id: 0, name: "", image: "", imageData: .none, homeworld: "", gender: "", height: "", mass: "", species: "", skinColor: "", eyeColor: "")] {
        
        didSet {
            shouldUpdateHeroesArray.toggle()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
}
