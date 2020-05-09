//
//  HeroModel.swift
//  AnimationsTest
//
//  Created by Enoxus on 26.04.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation
import RealmSwift

@objcMembers
/// Hero model to store in Realm
class HeroModel: Object {
    
    dynamic var id = 0
    dynamic var name = String()
    dynamic var bio = String()
    dynamic var image = String()
    dynamic var imageData: Data? = .none
    dynamic var homeworld: String? = .none
    dynamic var gender = String()
    dynamic var height = RealmOptional<Double>()
    dynamic var mass = RealmOptional<Int>()
    dynamic var species = String()
    dynamic var skinColor: String? = .none
    dynamic var eyeColor: String? = .none
    
    override class func primaryKey() -> String? {
        return #keyPath(HeroModel.id)
    }
    
    func toDto() -> HeroDto {
        
        let dtoName = name
        let dtoImage = image
        let dtoHome = "Homeword: \(homeworld ?? "unknown")"
        let dtoGender = "Gender: \(gender)"
        let dtoHeight = "Height: \(height.value == nil ? "unknown" : String(height.value!))"
        let dtoMass = "Mass: \(mass.value == nil ? "unknown" : String(mass.value!))"
        let dtoSpecies = "Species: \(species)"
        let dtoSkinColor = "Skin color: \(skinColor ?? "unknown")"
        let dtoEyeColor = "Eye color: \(eyeColor ?? "unknown")"
        
        return HeroDto(id: id, name: dtoName, bio: bio, image: dtoImage, imageData: imageData, homeworld: dtoHome, gender: dtoGender, height: dtoHeight, mass: dtoMass, species: dtoSpecies, skinColor: dtoSkinColor, eyeColor: dtoEyeColor)
    }
}
