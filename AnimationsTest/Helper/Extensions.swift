//
//  Extensions.swift
//  AnimationsTest
//
//  Created by Евгений on 03.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation

extension Post {
    
    func toDto() -> PostDto {
        
        let postDto = PostDto(userId: self.userId!, id: self.id!, title: self.title!, body: self.body!, imageUrl: ProfileImageUrlConstructor.getUrlForProfile(with: self.userId!))
        return postDto
    }
}

extension PostModel {
    
    func toDto() -> PostDto {
        
        let postDto = PostDto(userId: self.userId, id: self.id, title: self.title, body: self.body, imageUrl: self.imageUrl)
        return postDto
    }
}

extension PostDto {
    
    func toModel() -> PostModel {
        
        let postModel = PostModel()
        postModel.setValuesForKeys([Constants.modelUserIdKey: userId, Constants.modelIdKey: id, Constants.modelTitleKey: title, Constants.modelBodyKey: body, Constants.modelImageUrlKey: imageUrl])
        return postModel
    }
}
