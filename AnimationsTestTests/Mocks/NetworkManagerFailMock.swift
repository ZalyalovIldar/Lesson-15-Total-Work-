//
//  NetworkManagerFailMock.swift
//  AnimationsTestTests
//
//  Created by Enoxus on 02.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
@testable import AnimationsTest

class NetworkManagerFailMock: NetworkManager {
    
    var shouldGetAllHeroes = false
    
    func getAllHeroes(completion: @escaping (Result<[Hero], Error>) -> Void) {
        
        shouldGetAllHeroes.toggle()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            completion(.failure(NSError(domain: String(), code: 1, userInfo: .none)))
        }
    }
}
