//
//  MainMainPresenter.swift
//  Lesson-15-Total-Work-
//
//  Created by omeeer78 on 05/05/2020.
//  Copyright © 2020 ITIS. All rights reserved.
//

import Foundation

protocol MainModuleInput: class {
    
}

class MainPresenter: MainModuleInput, MainViewOutput, MainInteractorOutput {
    
    var navTitle: String {
        return "Heroes"
    }
    
    weak var view: MainViewInput!
    var interactor: MainInteractorInput!
    var router: MainRouterInput!
    var dataSource: MainDataSourceInput!

    //MARK: - MainViewOutput
    
    func viewIsReady() {
        interactor.getHeroesInfo()
    }
    
    func didActivateDeleteAction(at indexPath: IndexPath) {
        interactor.deleteHero(at: indexPath.row)
    }
    
    //MARK: - MainInteractorOutput
    func didFinishGettingHeroes(with heroes: [Hero]) {
        
        view.set(dataSource: dataSource)
        dataSource.heroes = heroes
        view.reloadTable()
    }
    
    func didFinishGettingHeroes(with error: Error) {
        
    }
    
}
