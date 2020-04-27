//
//  MainModuleConfigurator.swift
//  AnimationsTest
//
//  Created by Enoxus on 26.04.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
import UIKit

class MainModuleConfigurator {
    
    class func configureModule() -> UIViewController {
        
        let view = MainViewController()
        let presenter = MainPresenter()
        let interactor = MainInteractor()
        let router = MainRouter()
        let dataSource = MainDataSource()
        let realmManager = RealmManagerImpl()
        let networkManager = NetworkManagerImpl()
        
        view.presenter = presenter
        
        presenter.router = router
        presenter.interactor = interactor
        presenter.view = view
        presenter.dataSource = dataSource
        
        interactor.presenter = presenter
        interactor.realmManager = realmManager
        interactor.networkManager = networkManager
        
        router.view = view
        router.presenter = presenter
        
        return view
    }
}
