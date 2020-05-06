//
//  PostDto.swift
//  AnimationsTest
//
//  Created by Евгений on 03.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation

struct PostDto {
    
    var userId:     Int
    var id:         Int
    var title:      String
    var body:       String
    var imageUrl:   String
    
    init(userId: Int, id: Int, title: String, body: String, imageUrl: String) {
        
        self.userId = userId
        self.id = id
        self.title = title
        self.body = body
        self.imageUrl = imageUrl
    }
}
