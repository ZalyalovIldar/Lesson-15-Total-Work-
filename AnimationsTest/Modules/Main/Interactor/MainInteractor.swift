//
//  MainMainInteractor.swift
//  Lesson-15-Total-Work-
//
//  Created by omeeer78 on 05/05/2020.
//  Copyright © 2020 ITIS. All rights reserved.
//

import Foundation

protocol MainInteractorInput {
    func getHeroesInfo()
    func deleteHero(at index: Int)
}

protocol MainInteractorOutput: class {
    func didFinishGettingHeroes(with heroes: [Hero])
    func didFinishGettingHeroes(with error: Error)
}

class MainInteractor: MainInteractorInput {
    
    weak var output: MainInteractorOutput!
    
    var networkManager: NetworkManagerProtocol!
    
    func getHeroesInfo() {
        networkManager.getHeroesInfo { [weak self] result in
            
            switch result {
                
            case .failure(let error):
                
                DispatchQueue.main.async {
                    self?.output.didFinishGettingHeroes(with: error)
                }
                
            case .success(let heroes):
                
                DispatchQueue.main.async {
                    self?.output.didFinishGettingHeroes(with: heroes)
                }
                
            }
        }
    }
    
    func deleteHero(at index: Int) {
        print("Deleted")
    }
    
}
