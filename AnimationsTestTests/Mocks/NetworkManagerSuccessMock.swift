//
//  NetworkManagerSuccessMock.swift
//  AnimationsTestTests
//
//  Created by Enoxus on 02.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
@testable import AnimationsTest

class NetworkManagerSuccessMock: NetworkManager {
    
    var shouldGetAllHeroes = false
    
    func getAllHeroes(completion: @escaping (Result<[Hero], Error>) -> Void) {
        
        shouldGetAllHeroes.toggle()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            completion(.success([Hero(id: 0, name: String(), bio: String(), image: String(), homeworld: .none, gender: String(), height: .none, mass: .none, species: String(), skinColor: .none, eyeColor: .none)]))
        }
    }
}
