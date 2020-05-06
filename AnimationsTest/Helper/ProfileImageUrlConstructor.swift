//
//  ProfileImageUrlConstructor.swift
//  AnimationsTest
//
//  Created by Евгений on 03.05.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation

class ProfileImageUrlConstructor {
 
    class func getUrlForProfile(with id: Int) -> String {
        return "https://api.kwelo.com/v1/media/identicon/\(id)"
    }
}
