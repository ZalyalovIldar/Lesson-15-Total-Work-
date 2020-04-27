//
//  MainInteractorInput.swift
//  AnimationsTest
//
//  Created by Enoxus on 26.04.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation

protocol MainInteractorInput: AnyObject {
    
    /// tells interactor to obtain all heroes
    func fetchAllHeroes()
    
    /// tells interactor that user wants to rename hero with given id
    /// - Parameters:
    ///   - id: id of the hero to rename
    ///   - name: new name
    func renameRequested(on id: Int, new name: String)
    
    /// tells interactor that user wants to delete hero with given id
    /// - Parameter id: id of the hero to delete
    func deleteRequested(on id: Int)
    
    /// tells interactor to save image data
    /// - Parameters:
    ///   - data: image data
    ///   - id: id of the object to save image in
    func saveImage(data: Data, id: Int)
}
