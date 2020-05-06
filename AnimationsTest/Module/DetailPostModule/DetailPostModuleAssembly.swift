//
//  DetailPostModuleAssembly.swift
//  AnimationsTest
//
//  Created by Евгений on 06.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
import UIKit

class DetailPostModuleAssembly: NSObject {
    
    @IBOutlet weak var viewController: UIViewController?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let view = viewController as? DetailPostModuleViewController else { return }
        
        let presenter = DetailPostModulePresenter()
        let interactor = DetailPostModuleInteractor()
        let router = DetailPostModuleRouter()
        let databaseManager = RealmDatabaseManagerImpl()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        interactor.databaseManager = databaseManager
        
        router.view = view
    }
}
