//
//  DBManager.swift
//  AnimationsTest
//
//  Created by Amir on 06.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import RealmSwift

protocol DBManagerProtocol {
    func save(model hero: RealmHero)
    func saveArray(of heroes: [Hero])
    func renameHero(for key: Int, with newName: String)
    func deleteHero(with key: Int)
    func fetchAllHeroes(completion: @escaping ([HeroDTO]) -> Void)
}

class DBManager: DBManagerProtocol {
    
    private lazy var realm = try! Realm(configuration: .defaultConfiguration)
    
    func save(model hero: RealmHero) {
        
    }
    
    func saveArray(of heroes: [Hero]) {
        
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            
            try? self?.realm.write {
                self?.realm.add(heroes.map( {$0.convertToRealmModel()} ))
            }
        }
    }
    
    func renameHero(for key: Int, with newName: String) {
        
    }
    
    func deleteHero(with key: Int) {
        
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
                        
            guard let objectToDelete = self?.realm.object(ofType: RealmHero.self, forPrimaryKey: key) else { return }
            
            try? self?.realm.write {
                self?.realm.delete(objectToDelete)
            }
        }
    }
    
    func fetchAllHeroes(completion: @escaping ([HeroDTO]) -> Void) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let realm = try! Realm()
            
            let objects = Array(realm.objects(RealmHero.self)
                .sorted(byKeyPath: #keyPath(RealmHero.id), ascending: true))
                .map({ $0.convertTDTO()})
            
            DispatchQueue.main.async {
                completion(objects)
            }
        }
    }
    
}
