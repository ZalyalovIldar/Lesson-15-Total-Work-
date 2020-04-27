//
//  MainPresenter.swift
//  AnimationsTest
//
//  Created by Enoxus on 26.04.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation

class MainPresenter: MainInteractorOutput, MainViewOutput, MainRouterOutput {
    
    var interactor: MainInteractorInput!
    var dataSource: MainDataSourceInput!
    var router: MainRouterInput!
    weak var view: MainViewInput!
    
    //MARK: - Interactor Output
    func didFinishFetchingHeroes(result: [HeroDto]) {
        
        dataSource.heroes = result
        view.displayTableView()
        view.reloadData()
    }
    
    func didFinishFetchingHeroes(with error: Error) {
        router.showErrorAlert(text: error.localizedDescription)
    }
    
    func didReceiveUpdateNotification(new: [HeroDto], deletions: [Int], insertions: [Int], modifications: [Int]) {
        
        dataSource.heroes = new
        view.reloadData(deletions: deletions.map({ IndexPath(row: $0, section: .zero ) }),
                        insertions: insertions.map({ IndexPath(row: $0, section: .zero ) }),
                        modifications: modifications.map({ IndexPath(row: $0, section: .zero ) }))
    }
    
    //MARK: - View Output
    func viewDidLoad() {
        
        view.displayLoadingView()
        view.registerDataSource(dataSource)
        interactor.fetchAllHeroes()
    }
    
    func didPressedDelete(on indexPath: IndexPath) {
        interactor.deleteRequested(on: dataSource.heroes[indexPath.row].id)
    }
    
    func didPressedRename(on indexPath: IndexPath) {
        router.showRenamingAlert(initial: dataSource.heroes[indexPath.row].name, indexPath: indexPath)
    }
    
    //MARK: - Router Output
    func userDidEnterNewName(for indexPath: IndexPath, name: String) {
        interactor.renameRequested(on: dataSource.heroes[indexPath.row].id, new: name)
    }
}
