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
            completion([HeroDto(id: 0, name: "", bio: "", image: "", imageData: .none, homeworld: "", gender: "", height: "", mass: "", species: "", skinColor: "", eyeColor: "")])
        }
    }
    
    func delete(by primaryKey: Int) {
        
        if primaryKey != 0 {
            shouldNotifyInteractor.toggle()
        }
    }
    
    func saveBatch(_ models: [Hero], completion: @escaping () -> Void) {
        
        shouldNotifyInteractor.toggle()
        completion()
        
        if isBeingObserved {
            onUpdate([], [], [])
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
