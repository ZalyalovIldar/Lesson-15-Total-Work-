//
//  DetailPostModulePresenter.swift
//  AnimationsTest
//
//  Created by Евгений on 06.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation

class DetailPostModulePresenter: DetailPostModuleInteractorOutput, DetailPostModuleViewOutput {
    
    weak var view: DetailPostModuleViewInput!
    var interactor: DetailPostModuleInteractorInput!
    var router: DetailPostModuleRouterInput!
    
    func didPressSaveButton(on post: PostDto, isChanged: Bool, delegate: PostsModuleViewControllerEditingProtocol) {
        
        if isChanged {
            interactor.saveChanges(of: post, delegate: delegate)
        } else {
            router.endEditing()
        }
    }
    
    func didFinishSavingChanges(delegate: PostsModuleViewControllerEditingProtocol) {
        router.endEditingWithUpdate(delegate: delegate)
    }
    
}
