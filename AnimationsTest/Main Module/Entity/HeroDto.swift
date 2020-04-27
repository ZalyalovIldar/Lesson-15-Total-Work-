//
//  HeroDto.swift
//  AnimationsTest
//
//  Created by Enoxus on 26.04.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation

/// hero dto for using in the view controllers
struct HeroDto {
    
    let id: Int
    let name: String
    let image: String
    var imageData: Data?
    let homeworld: String
    let gender: String
    let height: String
    let mass: String
    let species: String
    let skinColor: String
    let eyeColor: String
}
