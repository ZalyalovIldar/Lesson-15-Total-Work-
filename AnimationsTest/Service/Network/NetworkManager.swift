//
//  NetworkManager.swift
//  AnimationsTest
//
//  Created by Enoxus on 26.04.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
import Alamofire

protocol NetworkManager {
    
    /// Retrieves all the heroes from API
    /// - Parameter completion: block that is called when the data is received
    func getAllHeroes(completion: @escaping (Result<[Hero], Error>) -> Void)
}
