//
//  NetworkManagerMock.swift
//  AnimationsTestTests
//
//  Created by Евгений on 10.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
@testable import AnimationsTest

class NetworkManagerMock: NetworkManager {
    
    var isLoadedPostsFromNetwork = false
    
    func loadPostsFromNetwork(completion: @escaping ([Post]) -> Void) {
        isLoadedPostsFromNetwork = true
    }
}
