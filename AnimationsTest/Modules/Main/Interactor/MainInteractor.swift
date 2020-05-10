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
    func didFinishGettingHeroes(with heroes: [HeroDTO])
    func didFinishGettingHeroes(with error: Error)
}

class MainInteractor: MainInteractorInput {
    
    weak var output: MainInteractorOutput!
    
    var networkManager: NetworkManagerProtocol!
    var dbManager: DBManagerProtocol!
    
    func getHeroesInfo() {
        
        dbManager.fetchAllHeroes { [weak self] heroes in
            if !heroes.isEmpty {
                self?.output.didFinishGettingHeroes(with: heroes)
            } else {
                self?.networkManager.getHeroesInfo { result in
                    
                    switch result {
                        
                    case .failure(let error):
                        
                        DispatchQueue.main.async {
                            self?.output.didFinishGettingHeroes(with: error)
                        }
                        
                    case .success(let heroes):
                        
                        self?.dbManager.saveArray(of: heroes)
                        
                        DispatchQueue.main.async {
                            self?.output.didFinishGettingHeroes(with: heroes.map({ $0.convertDTO() }))
                        }
                    }
                }
            }
        }
    }
    
    func deleteHero(at index: Int) {
        dbManager.deleteHero(with: index)
    }
}
