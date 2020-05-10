//
//  PostsModuleAssembly.swift
//  AnimationsTest
//
//  Created by Евгений on 03.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
import UIKit

class PostsModuleAssembly: NSObject {
    
    @IBOutlet weak var viewController: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let view = viewController as? PostsModuleViewController else { return }
        
        let presenter = PostsModulePresenter()
        let interactor = PostsModuleInteractor()
        let router = PostsModuleRouter()
        let networkManager = NetworkManagerImpl()
        let databaseManager = RealmDatabaseManagerImpl()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        interactor.networkManager = networkManager
        interactor.databaseManager = databaseManager
        
        router.view = view
    }
}
