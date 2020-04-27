//
//  MainInteractor.swift
//  AnimationsTest
//
//  Created by Enoxus on 26.04.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation

class MainInteractor: MainInteractorInput {
    
    weak var presenter: MainInteractorOutput!
    var realmManager: RealmManager!
    var networkManager: NetworkManager!
    
    //MARK: - Interactor Input
    func fetchAllHeroes() {
        
        // firstly, ask for a cached copy of data
        realmManager.getAll { [weak self] result in
            
            // if it's not empty then return it
            if !result.isEmpty {
                
                DispatchQueue.main.async {
                    
                    self?.startObservingRealm()
                    self?.presenter.didFinishFetchingHeroes(result: result)
                }
            }
            else {
                // else, fetch all the heroes from api
                self?.networkManager.getAllHeroes { networkResult in
                    
                    switch networkResult {
                    
                    // if request has failed then return with error
                    case .failure(let error):
                        
                        DispatchQueue.main.async {
                            self?.presenter.didFinishFetchingHeroes(with: error)
                        }
                    case .success(let heroes):
                        
                        // else, if data is received, tell persistent layer to save it
                        self?.realmManager.saveBatch(heroes) {
                            
                            // when the data is saved (which could take some time becaues it is also saving images as data)
                            // subscribe to the realm
                            DispatchQueue.main.async {
                                
                                self?.startObservingRealm()
                            }
                        }
                        // and then return with fetched entities
                        DispatchQueue.main.async {
                            self?.presenter.didFinishFetchingHeroes(result: heroes.map({ $0.toDto() }))
                        }
                    }
                }
            }
        }
    }
    
    func saveImage(data: Data, id: Int) {
        
        realmManager.saveImage(imageData: data, primaryKey: id)
    }
    
    func renameRequested(on id: Int, new name: String) {
        
        realmManager.renameObject(with: id, new: name)
    }
    
    func deleteRequested(on id: Int) {
        
        realmManager.delete(by: id)
    }
    
    //MARK: - Util
    private func startObservingRealm() {
        
        realmManager.observe { [weak self] deletions, insertions, modifications in
            
            // when notification is received, obtain all the entities from realm and pass them to the
            // presenter along with changed indices
            self?.realmManager.getAll { realmResult in
                
                DispatchQueue.main.async {
                    self?.presenter.didReceiveUpdateNotification(new: realmResult, deletions: deletions, insertions: insertions, modifications: modifications)
                }
            }
        }
    }
}
