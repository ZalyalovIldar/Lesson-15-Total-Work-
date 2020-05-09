//
//  Hero.swift
//  AnimationsTest
//
//  Created by Enoxus on 26.04.2020.
//  Copyright © 2020 Ildar Zalyalov. All rights reserved.
//

import Foundation

/// hero model that is obtained from api
struct Hero: Codable {
    
    let id: Int
    let name: String
    let bio: String
    let image: String
    var homeworld: String?
    let gender: String
    let height: Double?
    let mass: Int?
    let species: String
    let skinColor: String?
    let eyeColor: String?
    
    init(id: Int, name: String, bio: String, image: String, homeworld: String?, gender: String, height: Double?, mass: Int?, species: String, skinColor: String?, eyeColor: String?) {
        
        self.id = id
        self.name = name
        self.bio = bio
        self.image = image
        self.homeworld = homeworld
        self.gender = gender
        self.height = height
        self.mass = mass
        self.species = species
        self.skinColor = skinColor
        self.eyeColor = eyeColor
    }
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case name
        case bio
        case image
        case homeworld
        case gender
        case height
        case mass
        case species
        case skinColor
        case eyeColor
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        bio = try container.decode(String.self, forKey: .bio)
        image = try container.decode(String.self, forKey: .image)
        homeworld = try? container.decode(String.self, forKey: .homeworld)
        
        if homeworld == nil {
            homeworld = try? container.decode([String].self, forKey: .homeworld).joined(separator: ", ")
        }
        
        gender = try container.decode(String.self, forKey: .gender)
        height = try? container.decode(Double.self, forKey: .height)
        mass = try? container.decode(Int.self, forKey: .mass)
        species = try container.decode(String.self, forKey: .species)
        skinColor = try? container.decode(String.self, forKey: .skinColor)
        eyeColor = try? container.decode(String.self, forKey: .eyeColor)
        id = try container.decode(Int.self, forKey: .id)
    }
    
    /// method that converts the model to a dto that is used in a view
    func toDto() -> HeroDto {
        
        let dtoName = name
        let dtoImage = image
        let dtoHome = "Homeword: \(homeworld ?? "unknown")"
        let dtoGender = "Gender: \(gender)"
        let dtoHeight = "Height: \(height == nil ? "unknown" : String(height!))"
        let dtoMass = "Mass: \(mass == nil ? "unknown" : String(mass!))"
        let dtoSpecies = "Species: \(species)"
        let dtoSkinColor = "Skin color: \(skinColor ?? "unknown")"
        let dtoEyeColor = "Eye color: \(eyeColor ?? "unknown")"
        
        return HeroDto(id: id, name: dtoName, bio: bio, image: dtoImage, imageData: .none, homeworld: dtoHome, gender: dtoGender, height: dtoHeight, mass: dtoMass, species: dtoSpecies, skinColor: dtoSkinColor, eyeColor: dtoEyeColor)
    }
    
    func toRealmModel() -> HeroModel {
        
        let model = HeroModel()
        
        model.id = id
        model.name = name
        model.image = image
        model.bio = bio
        model.imageData = .none
        model.homeworld = homeworld
        model.gender = gender
        model.height.value = height
        model.mass.value = mass
        model.species = species
        model.skinColor = skinColor
        model.eyeColor = eyeColor
        
        return model
    }
}
