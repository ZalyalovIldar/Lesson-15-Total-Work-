//
//  NetworkManager.swift
//  AnimationsTest
//
//  Created by Евгений on 03.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation

protocol NetworkManager {
    
    func loadPostsFromNetwork(completion: @escaping ([Post]) -> Void)
}
