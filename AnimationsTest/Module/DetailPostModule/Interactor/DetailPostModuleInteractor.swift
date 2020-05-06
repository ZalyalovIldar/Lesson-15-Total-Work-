//
//  DetailPostModuleInteractor.swift
//  AnimationsTest
//
//  Created by Евгений on 06.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation

class DetailPostModuleInteractor: DetailPostModuleInteractorInput {
    
    var presenter: DetailPostModuleInteractorOutput!
    var databaseManager: RealmDatabaseManager!
    
    func saveChanges(of post: PostDto, delegate: PostsModuleViewControllerEditingProtocol) {
        
        databaseManager.updatePost(post: post)
        presenter.didFinishSavingChanges(delegate: delegate)
    }
}
