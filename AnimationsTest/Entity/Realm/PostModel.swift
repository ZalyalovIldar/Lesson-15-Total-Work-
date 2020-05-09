//
//  PostModel.swift
//  AnimationsTest
//
//  Created by Евгений on 06.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
class PostModel: Object {
    
    dynamic var userId = Int()
    dynamic var id = Int()
    dynamic var title = String()
    dynamic var body = String()
    dynamic var imageUrl = String()
    
    override class func primaryKey() -> String? {
        return #keyPath(PostModel.id)
    }
}



