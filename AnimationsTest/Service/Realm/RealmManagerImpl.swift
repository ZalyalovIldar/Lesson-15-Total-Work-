//
//  RealmManagerImpl.swift
//  AnimationsTest
//
//  Created by Enoxus on 26.04.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
import RealmSwift

class RealmManagerImpl: RealmManager {
    
    /// array that holds strong references to the notification tokens
    var observerTokens = [NotificationToken]()
        
    func observe(onUpdate: @escaping ([Int], [Int], [Int]) -> Void) {
        
        let mainRealm = try! Realm()
        
        let token = mainRealm.objects(HeroModel.self).sorted(byKeyPath: #keyPath(HeroModel.id), ascending: true).observe { block in
            
            switch block {

            case .update(_, deletions: let deletions, insertions: let insertions, modifications: let modifications):
                onUpdate(deletions, insertions, modifications)
            default:
                break
            }
        }
        
        observerTokens.append(token)
    }
    
    func getAll(completion: @escaping ([HeroDto]) -> Void) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let realm = try! Realm()
            
            let objects = Array(realm.objects(HeroModel.self).sorted(byKeyPath: #keyPath(HeroModel.id), ascending: true)).map({ $0.toDto() })
            
            completion(objects)
        }
    }
    
    func get(by primaryKey: Int, completion: @escaping (HeroDto?) -> Void) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let realm = try! Realm()
            
            let object = realm.object(ofType: HeroModel.self, forPrimaryKey: primaryKey)
            
            guard let objectUnwrapped = object else {
                
                completion(.none)
                return
            }
            
            completion(objectUnwrapped.toDto())
        }
    }
    
    func delete(by primaryKey: Int) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let realm = try! Realm()
            
            if let objectToDelete = realm.object(ofType: HeroModel.self, forPrimaryKey: primaryKey) {
                
                try? realm.write {
                    realm.delete(objectToDelete)
                }
            }
        }
    }
    
    func save(_ model: Hero) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let realm = try! Realm()
            
            guard let imageUrl = URL(string: model.image), let imageData = try? Data(contentsOf: imageUrl) else { return }
            
            let realmModel = model.toRealmModel()
            realmModel.imageData = imageData
            
            try? realm.write {
                
                realm.add(realmModel)
            }
        }
    }
    
    func saveBatch(_ models: [Hero], completion: @escaping () -> Void) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let realm = try! Realm()
            var objects = [Object]()
            
            for model in models {
                
                guard let imageUrl = URL(string: model.image), let imageData = try? Data(contentsOf: imageUrl) else { continue }
                
                let realmModel = model.toRealmModel()
                realmModel.imageData = imageData
                
                objects.append(realmModel)
            }
            
            try? realm.write {
                
                realm.add(objects)
            }
            
            completion()
        }
    }
    
    func renameObject(with primaryKey: Int, new name: String) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            let realm = try! Realm()
            
            guard let objectToRename = realm.object(ofType: HeroModel.self, forPrimaryKey: primaryKey) else { return }
            
            try? realm.write {
                
                objectToRename.name = name
                realm.add(objectToRename, update: .modified)
            }
        }
    }
}
