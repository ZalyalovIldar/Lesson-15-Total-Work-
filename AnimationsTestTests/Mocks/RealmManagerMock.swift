//
//  RealmManagerMock.swift
//  AnimationsTestTests
//
//  Created by Enoxus on 02.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
@testable import AnimationsTest

class RealmManagerMock: RealmManager {
    
    var hasCheckedForCachedCopy = false
    
    var shouldReturnEmptyListOnGetAll = false
    
    var shouldNotifyInteractor = false
    
    var onUpdate: (([Int], [Int], [Int]) -> Void)!
        
    /// added to simulate realm notifications
    weak var interactor: MainInteractor!
    
    var isBeingObserved = false
    
    func observe(onUpdate: @escaping ([Int], [Int], [Int]) -> Void) {
        
        self.onUpdate = onUpdate
        isBeingObserved.toggle()
    }
    
    func getAll(completion: @escaping ([HeroDto]) -> Void) {
        
        hasCheckedForCachedCopy.toggle()
        
        if shouldReturnEmptyListOnGetAll {
            completion([])
        }
        else {
            completion([HeroDto(id: 0, name: "", image: "", imageData: .none, homeworld: "", gender: "", height: "", mass: "", species: "", skinColor: "", eyeColor: "")])
        }
    }
    
    func get(by primaryKey: Int, completion: @escaping (HeroDto?) -> Void) {
        
        if primaryKey == 0 {
            completion(.none)
        }
        else {
            completion(.init(id: .zero, name: String(), image: String(), imageData: .none, homeworld: String(), gender: String(), height: String(), mass: String(), species: String(), skinColor: String(), eyeColor: String()))
        }
    }
    
    func delete(by primaryKey: Int) {
        
        if primaryKey != 0 {
            shouldNotifyInteractor.toggle()
        }
    }
    
    func save(_ model: Hero) {
        
        shouldNotifyInteractor.toggle()
        onUpdate([], [.zero], [])
        
    }
    
    func saveBatch(_ models: [Hero], completion: @escaping () -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            completion()
        }
    }
    
    func renameObject(with primaryKey: Int, new name: String) {
        
        if primaryKey != 0 {
            
            shouldNotifyInteractor.toggle()
        }
    }
    
    func saveImage(imageData: Data, primaryKey: Int) {
        
        shouldNotifyInteractor.toggle()
    }
}
