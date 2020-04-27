//
//  MainDataSourceOutput.swift
//  AnimationsTest
//
//  Created by Enoxus on 27.04.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation

protocol MainDataSourceOutput: AnyObject {
    
    /// tells presenter that some image is loaded and needs to be cached
    /// - Parameters:
    ///   - data: data to save
    ///   - id: id of the object to save image in
    func didLoadImage(data: Data, id: Int)
}
