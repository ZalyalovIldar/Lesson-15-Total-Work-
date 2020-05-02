//
//  InteractorMock.swift
//  AnimationsTestTests
//
//  Created by Enoxus on 02.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
@testable import AnimationsTest

class InteractorMock: MainInteractorInput {
    
    var shouldFetchAllHeroes = false
    var shouldPerformDelete = false
    var shouldPerformRename = false
    var shouldSaveImage = false
    
    weak var presenter: MainInteractorOutput!
    
    private var heroes = [HeroDto(id: 0, name: "", image: "", imageData: .none, homeworld: "", gender: "", height: "", mass: "", species: "", skinColor: "", eyeColor: "")]
    
    func fetchAllHeroes() {
        
        presenter.didFinishFetchingHeroes(result: heroes)
        shouldFetchAllHeroes.toggle()
    }
    
    func renameRequested(on id: Int, new name: String) {
        
        shouldPerformRename.toggle()
        guard let idx = heroes.firstIndex(where: { $0.id == id }) else { return }
        
        presenter.didReceiveUpdateNotification(new: heroes, deletions: [], insertions: [], modifications: [idx])
    }
    
    func deleteRequested(on id: Int) {
        
        shouldPerformDelete.toggle()
        guard let idx = heroes.firstIndex(where: { $0.id == id }) else { return }
        
        presenter.didReceiveUpdateNotification(new: heroes, deletions: [idx], insertions: [], modifications: [])
    }
    
    func saveImage(data: Data, id: Int) {
        
        shouldSaveImage.toggle()
        guard let idx = heroes.firstIndex(where: { $0.id == id }) else { return }
        
        presenter.didReceiveUpdateNotification(new: heroes, deletions: [], insertions: [], modifications: [idx])
    }
}
